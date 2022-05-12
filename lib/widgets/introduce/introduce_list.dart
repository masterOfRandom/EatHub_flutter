import 'package:eathub/table_pick_deactivated_button.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/utils/global_var.dart';
import 'package:eathub/widgets/my_page/withdrawal_dialog.dart';
import 'package:eathub/table_pick_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:new_version/new_version.dart';
import 'package:url_launcher/url_launcher.dart';

class IntroduceList extends StatefulWidget {
  const IntroduceList({Key? key}) : super(key: key);

  @override
  State<IntroduceList> createState() => _SettingListState();
}

class _SettingListState extends State<IntroduceList> {
  bool isMore = false;
  bool visible = false;
  VersionStatus? versionStatus;
  bool isExistNewVersion = false;

  initVersionStatus() async {
    versionStatus = await NewVersion().getVersionStatus();
    if (versionStatus != null) {
      if (versionStatus!.localVersion == versionStatus!.storeVersion) {
        isExistNewVersion = false;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initVersionStatus();
  }

  Widget _myPageTile({
    required String text,
    required VoidCallback callback,
  }) {
    return ListTile(
      title: Text(text),
      trailing: const Icon(
        Icons.expand_more,
        color: grayScaleGray4,
      ),
      onTap: callback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _myPageTile(
              text: '이용약관',
              callback: () async {
                await launch(termsOfServiceUrl);
              }),
          const Divider(),
          _myPageTile(
              text: '개인 정보 처리 방침',
              callback: () async {
                await launch(termsOfPrivacyPolicyUrl);
              }),
          const Divider(),
          _myPageTile(
              text: '위치 기반 서비스 약관',
              callback: () async {
                await launch(termsOfLocationPolicyUrl);
              }),
          const Divider(),
          ListTile(
            title: Text(
              '더보기',
              style: TextStyle(
                color: isMore ? primaryRedColor : Colors.black,
              ),
            ),
            trailing: AnimatedRotation(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
              turns: isMore ? 0.5 : 0,
              child: Icon(
                Icons.expand_more,
                color: isMore ? primaryRedColor : grayScaleGray4,
              ),
            ),
            onTap: () {
              if (isMore) {
                visible = false;
              }
              isMore = !isMore;
              setState(() {});
            },
          ),
          const SizedBox(height: 8),
          AnimatedContainer(
            decoration: isMore
                ? BoxDecoration(
                    border: Border.all(color: grayScaleGray5),
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(10)))
                : BoxDecoration(
                    border: Border.all(color: const Color(0x00000000)),
                  ),
            duration: const Duration(milliseconds: 500),
            height: isMore ? 260 : 0,
            curve: Curves.ease,
            onEnd: () {
              isMore ? visible = true : visible = false;
              setState(() {});
            },
            child: visible
                ? Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('버전정보',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20)),
                        Text(
                          '현재버전 ${versionStatus != null ? versionStatus!.localVersion : '-'}',
                        ),
                        Text(
                          '최신버전 ${versionStatus != null ? versionStatus!.storeVersion : '-'}',
                          style: const TextStyle(color: primaryRedColor),
                        ),
                        const SizedBox(height: 16),
                        isExistNewVersion
                            ? TablePickElevatedButton(
                                isLoading: false,
                                text: '최신버전으로 업데이트',
                                callback: () async {
                                  if (versionStatus != null) {
                                    await launch(versionStatus!.appStoreLink);
                                  }
                                },
                              )
                            : const TablePickDeactivatedButton(
                                text: '최신버전입니다.', isLoading: false),
                        const SizedBox(height: 32),
                        TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) => const WithdrawalDialog());
                          },
                          child: const Text('회원탈퇴',
                              style: TextStyle(
                                  color: grayScaleGray3, fontSize: 20)),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ),
          !isMore
              ? const Divider(height: 0)
              : const SizedBox(
                  height: 0,
                ),
        ],
      ),
    );
  }
}
