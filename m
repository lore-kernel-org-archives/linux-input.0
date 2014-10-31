From: "Cole, JD" <JD.Cole@plantronics.com>
Subject: [PATCH 2/2] Added missing HID Consumer Page identifiers, for
 completeness.
Date: Fri, 31 Oct 2014 19:23:13 +0000
Message-ID: <899CD57B-10D4-4AB1-B006-50572BCD6871@plantronics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail3.plantronics.com ([198.231.10.49]:55914 "EHLO
	mail3.plantronics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757301AbaJaTYe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 15:24:34 -0400
Content-Language: en-US
Content-ID: <59AEF81130E0BD408BDF06BBB97F6369@plantronics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "jkosina@suse.cz" <jkosina@suse.cz>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "bleung@chromium.org" <bleung@chromium.org>, "Junge, Terry" <Terry.Junge@plantronics.com>, "Wesselman, Tom" <Tom.Wesselman@plantronics.com>, "Dsouza, Sunil" <Sunil.Dsouza@plantronics.com>

Adds CA and NAry usage type identifiers.

Signed-off-by: JD Cole <jd.cole@plantronics.com>
---
include/linux/hid.h |   24 ++++++++++++++++++++++++
1 file changed, 24 insertions(+)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index a63f2aa..58a89ed 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -236,6 +236,30 @@ struct hid_item {
#define HID_DG_TABLETPICK       0x000d0046

#define HID_CP_CONSUMERCONTROL  0x000c0001
+#define HID_CP_NUMERICKEYPAD   0x000c0002
+#define HID_CP_PROGRAMMABLEBUTTONS     0x000c0003
+#define HID_CP_MICROPHONE      0x000c0004
+#define HID_CP_HEADPHONE       0x000c0005
+#define HID_CP_GRAPHICEQUALIZER        0x000c0006
+#define HID_CP_FUNCTIONBUTTONS 0x000c0036
+#define HID_CP_SELECTION       0x000c0080
+#define HID_CP_MEDIASELECTION  0x000c0087
+#define HID_CP_SELECTDISC      0x000c00ba
+#define HID_CP_PLAYBACKSPEED   0x000c00f1
+#define HID_CP_PROXIMITY       0x000c0109
+#define HID_CP_SPEAKERSYSTEM   0x000c0160
+#define HID_CP_CHANNELLEFT     0x000c0161
+#define HID_CP_CHANNELRIGHT    0x000c0162
+#define HID_CP_CHANNELCENTER   0x000c0163
+#define HID_CP_CHANNELFRONT    0x000c0164
+#define HID_CP_CHANNELCENTERFRONT      0x000c0165
+#define HID_CP_CHANNELSIDE     0x000c0166
+#define HID_CP_CHANNELSURROUND 0x000c0167
+#define HID_CP_CHANNELLOWFREQUENCYENHANCEMENT  0x000c0168
+#define HID_CP_CHANNELTOP      0x000c0169
+#define HID_CP_CHANNELUNKNOWN  0x000c016a
+#define HID_CP_APPLICATIONLAUNCHBUTTONS        0x000c0180
+#define HID_CP_GENERICGUIAPPLICATIONCONTROLS   0x000c0200

#define HID_DG_CONFIDENCE       0x000d0047
#define HID_DG_WIDTH            0x000d0048
--
1.7.9.5


________________________________

CONFIDENTIALITY NOTICE: This e-mail transmission, and any documents, files or previous e-mail messages attached to it, may contain information that is confidential and/or legally privileged. If you are not the intended recipient, or a person responsible for delivering it to the intended recipient, please DO NOT disclose the contents to another person, store or copy the information in any medium, or use any of the information contained in or attached to this transmission for any purpose. If you have received this transmission in error, please immediately notify the sender by reply email or at privacy@plantronics.com, and destroy the original transmission and its attachments without reading or saving in any manner.

For further information about Plantronics - the Company, its products, brands, partners, please visit our website www.plantronics.com.
