Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.78.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798633;
	b=Sf0CKsO4xbCxmm/iF4aWstjlCTNAOKeBChFeO50s/qFqR5az8GYMMwmAzDjTQSxNkZcC
	 1ZonP+dQhKGjOdwqB8YpyXZCejTGMknPy6wOFbrzIHTtvA6lReikmKYsbcL/iCZ3/N6Z/
	 24Qil0yyNFy6lvbN4rLK+3DNupxghrym5t+owt9fyzFzvgJTNeBj4+MInjrPPaAU/JVJc
	 nnlUtD+/KRzPcs3Pa8Aag8hMNnbFHgX8fvTFcJ8rBczP/Ew3qgTfZMPvGaEqSdefwAMtm
	 avR2bRAkEJDEAQVrq8JeD7vcI9sOJjPa9aeoyklsoyiB0tWzmTw0D98hJtCBHMrTGEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798633;
	h=DMARC-Filter:Received:X-ICL-RepId:Dkim-Signature:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Info-Out:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-JNJ:X-Apple-Category-Label;
	bh=gO1bZ2nlZS0bURwAHAug1W0UNmJkzhac+JzOuVeKqjY=;
	b=dBKdCaW51uoROYzApntm89IRhFAMgy8ktLrrmF5zNJ7rYILy281NH6LTiQ/e7agsydfU
	 uY5Mj4CVPzfYMFyf/u3apM+EreIzLg/zCgJVHo/iUh2e+7an2aqYAnqJ/NDn3RqOka1Me
	 JioNWHlemgcHr1hFWGGq1h4DwlrbU9FLUKoNjPid4sM/kkXJ1EyvJo3Tp8mBh0kJPXLkB
	 lYAHqlSHP8o1MBCSUdVEDiJm0vEc+IdbkbXlvGUz5Lz4+ak0iD6FAf89yUfsVjKEtJICn
	 BehmZsYT/zjVGxr8lDgd4Sz2CeZm3IQrzrNRwMdIatzxpyGV/86/8ZUsiSYD2Br1LSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=icloud.com;
	spf=pass smtp.mailfrom=icloud.com;
	dkim=pass header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=j986ny4c;
	arc=none smtp.remote-ip=57.103.78.185
Received: from outbound.st.icloud.com (st-2004l-snip4-4.eps.apple.com [57.103.78.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E31606A31E
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 16:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26E31606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=icloud.com header.i=@icloud.com header.a=rsa-sha256 header.s=1a1hai header.b=j986ny4c
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-4 (Postfix) with ESMTPS id 631EE180A456;
	Fri, 27 Nov 2026 16:57:10 +0000 (UTC)
X-ICL-RepId: 01a21df0-7fc5-704b-b057-d95ccea61656
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1795798631; x=1827334631; bh=gO1bZ2nlZS0bURwAHAug1W0UNmJkzhac+JzOuVeKqjY=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=j986ny4cx/54vw79Xk0+QCzUthwaBKXHAuSrIA1pgIxciYN06+QMbCO2ugNfOX//i2ObDPr7AzKGZlKDDqCPqDH58EUpNpSn5eXIofEpAwxD+yOm3t+dYwJ733pLttKMthQniqYrhq9YlDafN15vqiWRknG9cGB+192rDE2yUPMuz3N8ZmretdLJEs3hEjwOEy2xtg9arAICo5aCcwGihxvI9BBSrdv2lvSWcsshecwV7XFaOJz4+CvlcTB0qUuBHluKrjVgU5YcUajsqGJAjTTRsz++Oj2pS/7ccyKakQMINXrkh7WObb8zjLCvFVSwzfzBd8fZBipuveoa/JNKLA==
Received: from machine.netbird.cloud (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-4 (Postfix) with ESMTPSA id EBF491816209;
	Fri, 27 Nov 2026 16:41:05 +0000 (UTC)
From: Marcelo Niendicker Grando <marcelogrando@icloud.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	Marcelo Niendicker Grando <marcelogrando@icloud.com>
Subject: [PATCH] HID: asus: add support for the ASUS Zenbook A14 (UX3407QA) keyboard
Date: Fri, 27 Nov 2026 13:40:52 -0300
Message-ID: <20261127164052.59518-1-marcelogrando@icloud.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=EZZd0/mC c=1 sm=1 tr=0 ts=6b09b666
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10
 a=5yNoK_3RFYUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=kibvr5HLtuNvmma_iept:22
 a=FWZx5dj72HHvF9NkQXT7:22 a=v3ZZPjhaAAAA:8 a=kSQo2tbCKcx2xoj0uy8A:9
X-Proofpoint-GUID: QTnzNswZs7ep3ov9bCN-1M8PO2HXnsCm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA2NyBTYWx0ZWRfX1i6zd6eSNdGX
 gHxckjvcGiT9wy3Iu4oxZWX6Z4isJxzYB7djuUZlqKTjn9egXc7O3J6+ZdVl1cc157lPFchCDib
 RsnCuiQPBvNKaurx5jAqCrGPRfspWTU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA2NyBTYWx0ZWRfX+i7h7rRDO5+Q
 hFZ2IQOsYSizCvK5vF5CHwV6obUF4tnz7K1kL4aeqoFa9hrC5G2GlrY7suU7Y7ufGRiorKKZxZ2
 cCj2Qi4U65QtSil7UH6wTdSTUsEza/XF+WbeQjNDr7bWJORDANXS/MT2eEXIcODfxPC3TxO+mXF
 RnKFN9sl+LoiCUmBPVabqTS1Cg2lopjQ/B2q4VRgTLp/XUUq7h2zpxRjvKHVtNPx650gYyc/mPs
 cYbbwfdCp1KM65UllhLaBkutXgOruKtZGLl1dUlN5jgEEsCVtxFOhfe0+WFCM6tM203xlxVBP/I
 um/bgBt0/wPnscGviDrR8HgjKnrfwUe+STkxC0QdMR53TFtERFM+wwnIQnty/c=
X-Proofpoint-ORIG-GUID: QTnzNswZs7ep3ov9bCN-1M8PO2HXnsCm
X-JNJ: AAAAAAAB3tQIC8KdXE8SHN21D38rz8Hm56mUy+Kp3XBuo3GKUNO/3YAJGTVaBHkWXSeOaY
 yOuFBX55jjItsgSmJucedjJLD4G0i1sYHuG2wx8q+7ev3zTLHGNfkyO+ZFvPY+oDOa4v7Y
 AZwXPBXzEtVrW3uAUVwsdAwCGVxtCbAu62gtCY0vS9Kqg/JliOfHzqq/e/o0XMALFN5DO3
 R5MZe7vfh2+e+u7CDCJCCIkp81IEcNPCxkyPy8VyAg3BvGWu5LCDl6OenfG7THcc70YCjq
 VI8E8wZ6pGjGwMhIOjbTJYtRBv0I5b5DaHJiw40t6MeZoxErtpLi7ftXSMy+RkcHf/8bgP
 LZ+dJJVo4ozodgi6Kg7Akp/Ni2JQx28aRm6lzw25YUUY7nt94gSg9ZrTtPDp2qAyZnPaVJ
 2eXsJnOgcmNSY04czLQa0JdQemxVvQV26XdBsWa5PxKyVlwYE57uJT2KIFNro/BgeyLCWd
 h689cXwDsl2fPRzwNmm13nrG54L750IzPVDaekEFKJyEAjRoChOTO+i1f8Avae5Y5VsjZO
 Rb5rxLlzRNnb7z8UjkhG0VwHUDFsivXaeZ8fckLIsGk94KJ05tRs2Gpui9UAfVsLW0LJ0n
 VrI0b41yu184ifHzKFGFOXfHJT/hre5i5hAjA1gOJUMf++/2QWbTIQPzRw4MAOo7FjwB2W
 05LBczS9JPqRpVHn6fOtcnGNxID2WESvNiaAoQInlJhihES/W8woGz+Ns1mql3+rM5T1Kd
 pN9BSxfuIybwoZi5hqb+M7Rff4VV/ygJ4KtuqikK9QPgEmJFcE7/UJWi+mnfuvqt7xTXAT
 D8FOekaCj2pCz+Te+mcgMXjxqpOzyLzVZpLXPxCY77RY60pZnUrOa+3f8TRu6xVz9CK+RQ
 6NRuFcPKKSsl1rkENdcubB7OzbPhE8oXZucZNBmTlq013BT0BxnHUBqSk3Xe3mEbMpjTJ/
 d/HjKyM5/8q61j2rNiZW12QTRT968mExxZEUrwYugpxZF1p91p5hFoXCPdwJVcdsx5cQyM
 rgZHdBzOE+1gYts06y9jWo4no4ANHVcey1EzP9ailOCAJ/KWPrUcrKJRDaLMkYINAx3flq
 GvhGPkuEqrE8iVSLbWBtvwQIuiy2TglrXP3+CAi2jSpozOkWuQI0qkxl4ft1P6fUizOR5N
 T4x7VWunkUKEnv2wQQuEUEs8hsHJgZaCXLYsh+s/IolGyDvpI5Qv8Q3QcfV71h0FjpbD8f
 oLqdLcoItDvNtgiPVLMha/fR4PhToA+pS4uyUvohFA8ofvZ/
X-Apple-Category-Label: MTY0OTI3MDQ4MjU6JGNhdGVnb3J5JF9QZXJzb25hbCw=

The internal I2C keyboard of the ASUS Zenbook A14 UX3407QA (Snapdragon X,
x1p42100) enumerates as 0B05:0220. It is currently driven by hid-generic,
which ignores the vendor report 0x5a (usage page 0xff31) the keyboard uses
for its Fn hotkeys, so Fn+F5/Fn+F6 (brightness) and the other Fn hotkeys
do nothing.

Bind it to hid-asus, which already maps these reports. Tested by binding
the device to hid-asus at runtime via new_id with driver_data 0: the
brightness hotkeys work and normal typing is unaffected.

Signed-off-by: Marcelo Niendicker Grando <marcelogrando@icloud.com>
---
Notes (not for the commit log):

- dmesg after binding (the handshake warning looks harmless, the keyboard
  works afterwards):
    asus 0018:0B05:0220.0002: input,hidraw1: I2C HID v1.00 Keyboard [hid-over-i2c 0B05:0220] on 0-0015
    asus 0018:0B05:0220.0002: Asus handshake 5a returned invalid response: 00 00 ... 00
- Report descriptor (132 bytes):
    05010906a1018502050719e029e71500250175019508810295017508810395057501
    050819012905910295017503910395067508150025650507190029dd8100c0050c09
    01a101850319002a3c021500263c02751095018100c00631ff0976a101855a19002a
    ff00150026ff0075089505810019002aff00150026ff007508953fb100c0
- The keyboard backlight answers the usual ASUS 0x5a feature reports
  (init 5a d0 8f 01, level 5a ba c5 c4 <0-3>), sent from userspace via
  hidraw. I did not add QUIRK_USE_KBD_BACKLIGHT: hid-asus now hands the
  backlight to asus-wmi through asus_hid_register_listener(), and asus-wmi
  is x86-only, so on this arm64 laptop the listener returns -ENODEV. Getting
  the backlight working here would need a fallback LED in hid-asus when
  asus-wmi is absent; I'm happy to test patches for that.
- DMI: ASUSTeK COMPUTER INC. ASUS Zenbook A14 UX3407QA_UX3407QA, BIOS UX3407QA.308 03/12/2025

 drivers/hid/hid-asus.c | 2 ++
 drivers/hid/hid-ids.h  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 4f5749c..d410907 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1813,6 +1813,8 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_KEYBOARD),
 	  I2C_KEYBOARD_QUIRKS | QUIRK_FILTER_CAMERA_COMPANION },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
+		USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_A14_KEYBOARD) },
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD), I2C_TOUCHPAD_QUIRKS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8590252..367602a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -222,6 +222,7 @@
 #define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD	0x184a
 #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
 #define USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_KEYBOARD	0x4b42
+#define USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_A14_KEYBOARD	0x0220
 #define USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD	0x0101
 #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1 0x1854
 #define USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2 0x1837
-- 
2.56.1

