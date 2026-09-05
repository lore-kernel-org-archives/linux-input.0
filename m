Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011072.outbound.protection.outlook.com [52.103.32.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EC2264F80;
	Sat,  5 Sep 2026 21:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645407; cv=fail; b=qFHt+rp/DwepaAjYnyw+oToMFWmke8xl9KgOkU8Asja4XHzr+HhCs+cMg0R/2r5NNmkQ7ewQj+1cIiSjcJ/n+RxgUMlKv/nNlujG3/Ra5fzsNhfOAaWXpwhBMAkZYXO7dYMNpeeFLZAMo3txZGqxJQiAMWZ4jG9yo9dOus4KH/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645407; c=relaxed/simple;
	bh=JsLT+tnGoOTQ1qLTZP3+VPp5L+ionnhVLT4ZDvCS+OI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dLAVTkq62Ec8kKcnIabVW3zjPKazxASZST9d/ajFzt771Uwo2lF0tVqOk2tAEWDh5X0bBo1RQ5I+Bd/xQfQ2VAPXcFihwa9ih3nqDstR28HgphZu944+q4qJrcstyV8xU/Xc3i9XLU60xN38bGfPYy+nRsD6MDHySX4Ngs2vOEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk; spf=pass smtp.mailfrom=hotmail.co.uk; dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b=bPUlwUo1; arc=fail smtp.client-ip=52.103.32.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.CO.UK header.i=@HOTMAIL.CO.UK header.b="bPUlwUo1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W375aPZSfyeyZiq8ywnd+GabujDU+BGFYtORbLiJ+PPcZ2zq/RvO59hJeULzNaQMIywZ47cSzTWYCWC5G9D+M8PQt3NF1F3ErZw4THPg5Aud/tQ8Cuv6IPYKzIsmx1gAXqUY23DDxrMhlqDar+0EyxwKblUedU68ZHUZ47WgsLOZwCTB7YLFgbRDteTaWLPah7OyLs1Ocf/l+zL9oztOKjqAjs2XMjn/FPWfZE+sq+zOYBuVyss2j1eX13XeQVZRYF9MdQlIq5dbGOYj/GDM8Yq4XHF+oCLKpsSMBZbIUphqwtDs0X8DJdSKCF6smpFCWp+ezmSVhRsskaeJ5ieisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjUIE+i7gM32TSFefkksTjhzi/s/R8YgEeF/bhlBALQ=;
 b=EoJdCvS3HM69LIWn8sDbBg03VLDNRqOKcS/RIEl1yCWuKWP6kvKUqFX9Ua5JbIitlYukndJMexOE7h8GdWwIi/HwTp2EU9EAEjChX9WPEFnUGKi+sYGspR1RINqBSaa/o1S9YjtueTh2XF8wX2HmLG23ZNRfMs5GUouyEt5xme3UTM65yKft44k69DhpDcN1MljD74JERYEv5RP6xVc6GB5zG567fPV/vAfAQGtmZp8x7KvKqQc1FRCKxCpjdKGBzJQy4P4j9+FiIJ7ZN6KeF26cDu2AJ8SVxdoBtaKnww06fDREgHA9L2w/hdIe5NYgzxntRLWT+m6Ns8RcCkkVRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjUIE+i7gM32TSFefkksTjhzi/s/R8YgEeF/bhlBALQ=;
 b=bPUlwUo1PbYw/Mn17czXWXUGTA8GN7ymqdkbFP5i6+CL6L9PKy51gI0Afp2ZdWvf4OrgmZ/3cc2iIgB9rWT2ApzAQsBtk7CW0YmZMYHvxjFm3rwJ0p0YQZVNFcfcaKJm6OKkv3ZnvC7fK8YhrXsWDi0Z10yC0iTFCLIQ4grotiK1cnR7zn8my7kNDK3lfml1JeSJXuMfaeGiYB61BxfUNXtM8JnwveMXgWZbDNYEl2aledytSd7cCETgstX6KHfGd06cB4yq+xd1chOAbiUloGtAso8Xq+0Bo3tZD/Kfz8T3xxzp93PEGKZ08a7PppRLJ8IOnMo+ANubF+BsI/AGrQ==
Received: from PAXP251MB0010.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:1d9::15)
 by VI0P251MB1076.EURP251.PROD.OUTLOOK.COM (2603:10a6:800:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 21:56:41 +0000
Received: from PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
 ([fe80::fb91:30d8:e31d:1f35]) by PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
 ([fe80::fb91:30d8:e31d:1f35%4]) with mapi id 15.21.0382.014; Sat, 5 Sep 2026
 21:56:40 +0000
From: Aamir Ahmed <elb12345@hotmail.co.uk>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Aamir Ahmed <elb12345@hotmail.co.uk>,
	Sashiko AI <sashiko-bot@kernel.org>
Subject: [PATCH] HID: wacom: Cancel init_work when probe fails after scheduling it
Date: Sat,  5 Sep 2026 22:56:37 +0100
Message-ID:
 <PAXP251MB001050EFD88752318EBA75F5C8B42@PAXP251MB0010.EURP251.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0261.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::14) To PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:1d9::15)
X-Microsoft-Original-Message-ID:
 <20260905215637.49357-1-elb12345@hotmail.co.uk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP251MB0010:EE_|VI0P251MB1076:EE_
X-MS-Office365-Filtering-Correlation-Id: 89235af4-50c2-4f5e-e51a-08df0b9890f3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|51005399006|23021999003|5062599005|5072599009|15080799012|37011999003|25031999004|41001999006|12121999013|8060799015|19110799012|4140399003|25010399006|40105399003|1602099012|10035399007|2607281247196008|30101999006|3412199025|440099028|4302099013|26104999009|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cTcvCuQB+Fuuir1XMCZ0y+/G5oFu0+EZVwqjButGaD0UmnyZrZSkRtF35F2n?=
 =?us-ascii?Q?hOhNf4lsyZsTqSspAjQfJX4iORQHm7r4Aq9usioelpkLN1EdNBr+f3r/0s+1?=
 =?us-ascii?Q?SBhnWSMeQiMwT3mDORSKKKjat9/98ybd+tVwfob7/jK8WnUwTtqFxbLjHPa4?=
 =?us-ascii?Q?TWQlnS0iwxN7EoyBH8MbNXjCaLrReIsaaVFoXHgO/D2PGIv+zRRo3aFubiKZ?=
 =?us-ascii?Q?0DQxxxGFamAnnFRrOFi1U/+0CT2WPmqbtBfmLgIHaDCk4sXrXZDsvHxXVI7l?=
 =?us-ascii?Q?jL9OGEhjRc65SKgPRAQTlrKh5G4ysxF4AIQQ25VzLk8rxvOlvXGELsC8mZAT?=
 =?us-ascii?Q?LjSHQqLLDUM883x0VZcKtwb6blX4PXNwjjjS7HN9WrOzVVvH/Lxjxii0FQL8?=
 =?us-ascii?Q?X8drLZ/slAwY6vnIF5FITQd+U0//3OPA7Lj2/Ob/OXy5lj99taLQCkOBwWXR?=
 =?us-ascii?Q?k14Vh3/AkVDPMkGKmGDzAunKtL+rNVnA1rkHAl9yHgssaSEsWDhWpDLRtcyq?=
 =?us-ascii?Q?nXIUTVwwrOcNsvF2VPvQxTsTzPWl1U6PGDgX5gekSRgW5mVBY5mnb3eLmI5x?=
 =?us-ascii?Q?yA6kEK5VL8QVbXCRNLGFi5LAt/gzSpcMqxG2PIJpRXBB89WA6o6uZykDaZ+V?=
 =?us-ascii?Q?SK/ZrQoP6C4c7pgySizfSl6kxs/AZn4nHaOLBU/ShYZJse0bKkl+fUaiFWxU?=
 =?us-ascii?Q?o0IcY7dKM2VYCZQfllUHBs5hegp/U8oVnAmwWaXTGDf1/5Z6TGeItOmpCTck?=
 =?us-ascii?Q?fMmQt3KwRosumOHh5WJ1NCFLWSOHPXeier8rUKskADpLI/S/m3BeZqlTW+67?=
 =?us-ascii?Q?omVQhZVlZSDySinAeQ50BCCh96PoaLanitqh4VE5WHar4kngKf25kliPemLF?=
 =?us-ascii?Q?ETK2TC2Nbg36JM8leMyNhxFxjFZ6tmsH3ApdA6TvBudXDzYStwB6yWb+mCFY?=
 =?us-ascii?Q?x2G0AZLq848vEv/pKXaONKX6YT6NBUGtGxKxeb+Ect+GajOyC6gyYtyJhoRk?=
 =?us-ascii?Q?Rx/66cFgAlfOgA2klAG/nbeXL9aD6CMzOdbUascbXXAE21lfOvCLGOiwqqUz?=
 =?us-ascii?Q?xmGB1wvs0amwmWITat1I9v3HaWVG6lxgNOEEVaKsiIQPlXJfOQMnsg00u3hn?=
 =?us-ascii?Q?+2y2wcySZHeWGK/NDvdqWQoAj6pxgsRgmr41I8mC017tepBE/JdTfMACoj8A?=
 =?us-ascii?Q?fny7Q5tT2o03Nq5gUVaIzIn6TSYz6ihxRdX+fIkzVtdyxawX36qZ0LY6N6Jl?=
 =?us-ascii?Q?djyS6rRZGYDWY/dss1W+?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bqj6bP574zkqbjmkjfn3B0njjYF9Xaba287K0loRFdMgm23zkmnwei78KTbH?=
 =?us-ascii?Q?P3wSPWnautN2Bs6neE+6rs/uyyJBlD9zOLKV43Tu3ox79WXFAIbklZOpQe7n?=
 =?us-ascii?Q?9ovZf79cS3DzGhsbmx9LqXHYKoxB2llq6r9pTan1bWsjebMp5qmEGRzdrCYl?=
 =?us-ascii?Q?YRQHrxZZZpUf8co7O9uUJvrhY1/lSoPKyyIKz/buBSC/NoA9LbbKBVOUw584?=
 =?us-ascii?Q?+axNP7dvBw2EoTka2kGZPjFh303JxpjqSXJh8EdKdz3tqXKOgEh/JRYt7HRU?=
 =?us-ascii?Q?V1u6SwqbtQf1Ex3D3j4hmivHkjSj9ROUaO5pQZUtF8nyC903gJBzbhR6U0Au?=
 =?us-ascii?Q?K4uCpq6tdOhK6OWU0za86idIvwAvaHRx0Jw3x01CZlriJ3H09iBFaMXgB+zf?=
 =?us-ascii?Q?5Xib8PVD5c0iV1zM+Z9RfBr0Cqf6ew41aNBe0fZqj/qnscEz7neFpOfWW79G?=
 =?us-ascii?Q?+dEgFWc4RNIXOFPho1ZweJ40YBz4deO3G8M7Iroo82noMnSW8dXBXTcvdEqe?=
 =?us-ascii?Q?7OxtUcsf0ewvXeEOgt6XFcAtLtkh6X/LuufM/Xi0A1aHEOcyTq80XKokRpRv?=
 =?us-ascii?Q?B0qPSA3uhxxTUE+T395yXOuKWCJCqSDN67OZYpFdkFNiHt2UGR6/Ezs3ENOh?=
 =?us-ascii?Q?d+d0y8OsQCjS0OlG1X5ncx0SF+EaH2Seg5x8DDRxSRDjbxKdx0ZUmiVnH22l?=
 =?us-ascii?Q?iU37/I0zGbMVCxYhUW7tFddR8AzWJctMt2h54G65t5sgKKPvNTiSE96+0zgk?=
 =?us-ascii?Q?EdM6OsqXfu/TWShlHa5kk6S6cWR+1CDyHhMT+L6FzWYabYQhXogDRW/dGRWm?=
 =?us-ascii?Q?1SGtoDV6YniIjVuuxFvlSxs1I1oFIvrKIohYhsfr6qHlrrkSj/MpVY404l0Y?=
 =?us-ascii?Q?us9duPFQvF69MYHXP5nYIothLAYrO2uzi+BeuacaAxLFegd2y29XZt+iA/kw?=
 =?us-ascii?Q?hIkOoqjtBPUIaYMVI0ipGpvBkUrFCJhUcUcPCX2k47ieg1cD2AbW02DjTU6v?=
 =?us-ascii?Q?4oyDgrhgpV+x+r8SY0R1EyBZgX4QkY41HmOcByCpc3SCxzfueYL642tSaeBy?=
 =?us-ascii?Q?7gtditg/4aoWk2If0qGPY2bY49yoVZewyZGPaGTYcuk5xJfg7foROmvB2V1V?=
 =?us-ascii?Q?Ovb/+7LGseFhXVUr43AG6eS/QrYsvAt/Pttk/FejwKDaEvJnralWIy9VFsff?=
 =?us-ascii?Q?WGvxcfVlzjKEM7w6GR8AH57bThJ7Q9w/1Nte5bDfCrA+/tGVUhbuAn4c33Z1?=
 =?us-ascii?Q?898JZA0Mvzdj95P4NQEQMN7427zu9HHWzDWLr2A1Q6akA3iZW+epf3S/mDMD?=
 =?us-ascii?Q?boXMp2UlQB26ze7pw0+nGKowwUO2TgU2KfF5Kl8U1TFRxHHqsh850BeR4X7f?=
 =?us-ascii?Q?1OHcsBx84cy5bO10Uf8TyuWiwaYZdGfAgG6fFkA0zJj4TyASLM4cLI7+5GXF?=
 =?us-ascii?Q?oh/twUT971znWvww2nU1BRJTXxjgDi5u?=
X-OriginatorOrg: sct-15-20-9412-3-msonline-outlook-fe3f5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 89235af4-50c2-4f5e-e51a-08df0b9890f3
X-MS-Exchange-CrossTenant-AuthSource: PAXP251MB0010.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 21:56:40.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P251MB1076

wacom_parse_and_register() schedules wacom->init_work with a one second
delay from wacom_query_tablet_data(), and only then opens the hardware
for devices with WACOM_DEVICETYPE_WL_MONITOR, that is the wireless
receiver's monitor interface and the ExpressKey Remote. If that
hid_hw_open() fails, the error path stops the hardware and releases the
driver's resources but leaves init_work pending.

wacom_probe() then returns the error and the HID core releases the
devres group it opened around probe(), which frees the wacom structure
allocated with devm_kzalloc(). When init_work runs a second later,
wacom_init_work() derives the wacom pointer from the work item, so
_wacom_query_tablet_data() and wacom_led_control() read and write freed
memory.

This is the only work item that can be pending at that point. The
others are scheduled from incoming reports, and the HID core drops
reports for the whole of probe() by holding driver_input_lock, which
this driver never releases early. The neighbouring BAMBOO_TOUCH error
path already cancels init_work before failing for the same reason.

Cancel init_work on the shared error path, after hid_hw_stop() as
wacom_remove() does. The cancel is harmless where the work was never
scheduled or was already cancelled.

Fixes: a544c619a54b ("HID: wacom: do not attempt to switch mode while in probe")
Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-input/20260905102908.ADE1F1F00A3D@smtp.kernel.org/
Assisted-by: LLM
Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
---
The Sashiko reviewer raised this in reply to "[PATCH] HID: wacom:
validate GRAPHIRE_BT report length" today, and had raised the same class
in May on "HID: wacom: stop hardware after post-start probe failures",
which reworked this error path without addressing it. I verified it
against drivers/base/dd.c, drivers/hid/hid-core.c (__hid_device_probe
releases the devres group on failure; __hid_input_report drops reports
while probe holds driver_input_lock) and drivers/hid/usbhid/hid-core.c
before writing this.

The reviewer also named wireless_work, battery_work, remote_work and the
timers. Those are only scheduled from reports, which cannot reach the
driver during probe, so I have not claimed them. Cancelling everything
wacom_remove() cancels would be harmless if you prefer a belt-and-braces
version; say so and I will send a v2.

The reviewer's remaining points, that the GRAPHIRE_BT length check could
be extended to the other device types handled by wacom_graphire_irq()
and to wacom_intuos_irq(), are hardening rather than a fix. Happy to
send that separately if wanted.

Compile-tested only, on x86_64 with GCC 13.3. I do not have a wireless
receiver or ExpressKey Remote, so the failure path was not exercised.
The fix and this changelog were drafted with an LLM assistant and
reviewed by hand.

 drivers/hid/wacom_sys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0eafa483b7f..ba8adefd932 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2501,6 +2501,7 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 
 fail_hw_stop:
 	hid_hw_stop(hdev);
+	cancel_delayed_work_sync(&wacom->init_work);
 fail:
 	wacom_release_resources(wacom);
 	return error;

base-commit: 654ae5d73c05bd2943d65636ce6cd0aa46e62f18
-- 
2.53.0.windows.1

