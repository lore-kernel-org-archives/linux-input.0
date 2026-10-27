Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139195;
	b=oHk1osvWawrIIOE6aVXEE5cYpeg85RIJ2McgS2vtCLBOq3W4lYhjk6Cswf7q1chkE5K3
	 y3WJYImMtYBsaX/8B3GEgUscqTMFnKgpsbWFWtIITtt8jSMVl4wRn1+KhLaHywn3NY2dW
	 DwCO52GhbcxoFnT9380oaERhcSRbwwgNqSw5QlV403HK4ZDqTiPdBfofvL//YVcT1RiAm
	 D2wmnTSo+P+enJPPKbai/5dMQaBc1GORJZCdDTbJb6aL1LP6eDQySJzlZY5PibTN+gAkQ
	 4GhYaUPQkAvTqeIERZmKQAnpbJIWksiv37TMHgxmqwYv+a5xj7YPHozkcTg0xq0tMWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=SF/2BCZg0521GRG2+QySkfLq2PA18MozDs+RfXA8UmI=;
	b=o3HpCip/kyPUrkAhG6Qd2J3WebUpq6LKtl0Hw73sZ8dYJxnlj6dhHP5bBkqKEC4uleoR
	 jNLfMZDfPSxocoAqsBcJpgdPsMvK0ep8+hfCCwtb7UPLJ5mUDZ/Ou4F2+Q3P2GxSfq+Zc
	 k1LebGTSS+KJQkgh4pJKKjZ5lROR8rtCWyljwGGRvBFehP5nsCGbOGGU4Z0Ox97D2HJI2
	 GikPq236oRXZXSOyt2ZEz2uqCsDs3L+4CHLouehNtfy5WJCp6y47EWVPwTRWpN7kBBdyn
	 /IL8hLHuNP4pqn48L4h2TvCA8xTN+0AUzPwHO31/yjOz+27zOQPtWwkCbRfmka3zo6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0szYlizp;
	arc=none smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F749606A327
	for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 22:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F749606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0szYlizp
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a9e87ba696so2246971fa.0
        for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 15:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793139193; x=1793743993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SF/2BCZg0521GRG2+QySkfLq2PA18MozDs+RfXA8UmI=;
        b=0szYlizpuqRBOChI8ZqX81upTdzV1Ljy6famKg5P0YB8f7/En7yQYA665tspTNTqMx
         Dh+GL+hrzs+mXZNSNHl+MbYnrPy9uoZPkNmC6cMYtsYD5hyd7MsOkFM94K1efULYpVFk
         1mhsKXBN7p4fTy0d2irwNQLwltMB8cnF/sNYo9O0/dPEBwz0wXO4XI/mjvYpz6rX72H2
         lb554H3rV2uSGnCQcYXYkPMhYOZJMQ9fprlryA171FgXyGybSh+8bPXA+MiEHwc+R7+A
         /y9wHKIpzGiqoV9GyoQRA+ZNqOuQyz3vM2dnKMdrDlCnNnVYstL9aFxyv/XNNuU6Gk5l
         XB7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793139193; x=1793743993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SF/2BCZg0521GRG2+QySkfLq2PA18MozDs+RfXA8UmI=;
        b=KHpFr3sw6PJO0NO3+Yj9wLCy//juB82gkZ4gy4mws8vrnWdAyzdeJX7yGlU4m2wrnn
         D7xVH0SlJlDyQF4G1l1SKT3jAjklP8jGVX4d1Ylu2Dz2kl7NUZFqCq+DcWBNiUIGFTeR
         yaLXT2GpdxMcHYoumwsX96RUrKuuxHkdXUtqTdxwWYj6SpatrQsmBWCGeJG0kYnNETqh
         AckRiMt4T3jWgJsQxhltavAuBvk4LVk5hd7C7SdI0KY8rlmdSFU47BWVUq1LGT3Kqs8e
         vcT0adjrWTByFLIccg/IwE+43pK+q2qFqGfPS0y5SFv14wnjj9ShbWAtMP0gzNreId9U
         5ggg==
X-Gm-Message-State: AFq9FYJoHU/IwAdM7ytz2H12iKB9Gbbc79y6oC4AMIce3ZUSs1TA6Psu
	R8J9jwHP5kaYgWQ0I9G2qZ81X7NGTihrvEkT4ZfygY/AIOm39dQth4wMHHNJzfxXc477hA==
X-Gm-Gg: AYBFou0fkvosAywrB4oHBvhdQogEXXv5qDLb9m14pvMZPQl0J1DY/sU8LTi3A4damWd
	iFPHWk3CIoG7v+VtTD7gMqio18nRUIwZKEllOCVkJ5fIAoMkye9FYCVVgMi60AVgQ6AmpVcpNRU
	ZTRl8sDxMFRxNAqtHgYX5F/22UoaD83hKarxOzqJ9eb+vYV5qUuYKB4JkOLpgeKu83J+GYI01hR
	NdNIJdrbyL9UTumYJcE/FYQEcJi0G3Cz0yxd8923QfsMfMa8ZARj6gwi+gD2mgHIBXCQYn5cste
	pcMYlsE0ehrDzGwftZpZL5iQjYt08eDrJs/5AZPCYvL8G3s77g1d31+li8wsc+soOb5L0JVfhC3
	7ehUmxtqaFF8KFrhBc73yKwQICZqXddoqtvFhN/0Tux5+svZTdbg48F95/CUP4KMiX0hBUaTi46
	JIvi53bLcy9AQpBk5qmB4WtklXwc92p8dEBjlpmtPhbPBqBJJBaLPqIthlfC3sq8CehsU88aTBg
	zlRtTYD7GimoWhjQFBWqPjYHzibFonb3bkIlPBcyFFwOhC99IhzymIv6a4CsPbXg/2Wpk+FlZn6
	lJG50JWAXdCi55mxhEDSQjLEEOZ+ncBUhTv3Hb0Nnbyt0bQT6lff
X-Received: by 2002:a05:6512:39d1:b0:5b7:f75a:ea68 with SMTP id 2adb3069b0e04-5bfcadc7276mr209189e87.35.1793139192453;
        Tue, 27 Oct 2026 15:13:12 -0700 (PDT)
Received: from localhost ([178.214.243.78])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac70993a57sm27289281fa.12.2026.10.27.15.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 15:13:10 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH] HID: apple: Map Fn+Esc to SysRq
Date: Wed, 28 Oct 2026 03:13:01 +0500
Message-ID: <20261027221301.296198-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Apple keyboards have no SysRq/Print Screen key, so nothing on them
reports KEY_SYSRQ and the magic SysRq key cannot be used from them
without a keymap change.

The documented way for keyboards without SysRq is to remap another key
to KEY_SYSRQ through the keymap (setkeycodes, EVIOCSKEYCODE, a udev
hwdb entry). Compact Apple keyboards have no unused key for that, so
the remap gives up a key. The free combinations are in the Fn layer,
which the keymap cannot reach: it is indexed by scancode, and Fn does
not change the scancode of the key pressed with it. Esc reports usage
0x70029 with and without Fn, so a keymap entry cannot tell Fn+Esc from
Esc.

hid-apple already implements the Fn layer and uses it to provide PC
keys that Apple keyboards lack: Fn+Backspace is Delete, Fn+Enter is
Insert, and Fn+arrow keys are Page Up, Page Down, Home and End. Add
SysRq to it as Fn+Esc, in the table used by the Magic Keyboard 2021 and
2024 models. No table in hid-apple translates Esc, so today Fn+Esc is
just a second Esc key.

The new entry has no flags, so like Fn+Enter it is translated only
while Fn is held, whether the top row defaults to media keys or to
function keys. Fn+Esc then reports KEY_SYSRQ, and the magic SysRq key
is Alt + Fn+Esc + command key.

Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
Tested on the internal keyboard of a MacBook Pro 16" (M1 Max) with the
Fedora Asahi Remix 7.1.13 kernel, where hid-apple handles that keyboard
with the same magic_keyboard_2021_and_2024_fn_keys table; the table is
identical to the one in mainline. In evtest, Esc alone still reports
KEY_ESC, and Fn+Esc reports KEY_SYSRQ on press and release, with the
Esc scancode 0x70029. Alt + Fn+Esc + H prints the SysRq help to the
kernel log. In mainline this table serves the Magic Keyboard 2021 and
2024 models over USB and Bluetooth; that path has not been tested on
hardware.

Background: this came up on linux-input in 2007 for an Apple USB
keyboard. A configurable SysRq keycode was proposed, and the advice was
to remap a key of that keyboard to KEY_SYSRQ instead, so that SysRq
keeps working with other keyboards [1]; that keyboard had a spare F13.
A generic alternative SysRq key was proposed again in 2021 and was not
merged; the objection was to adding a new SysRq key regardless of the
keyboard [2]. This patch leaves the sysrq code alone and makes the
keyboard itself report KEY_SYSRQ, on a Fn combination that has no other
function; Apple's list of macOS Fn shortcuts has none with Esc either
[3].

The same entry could also go into the other Apple tables for keyboards
with a physical Esc, for example older Magic Keyboards and the T2
MacBook Pro models with a dedicated Esc key. I kept this patch to the
table I could test.

If this is accepted, I will follow up with a line in
Documentation/admin-guide/sysrq.rst describing the combination.

[1] https://lore.kernel.org/linux-input/d120d5000707160541k64c40d0dgf661226806fd98c8@mail.gmail.com/
[2] https://lore.kernel.org/lkml/YYUxNaDG0DquQvke@kroah.com/T/
[3] https://support.apple.com/en-us/102650

 drivers/hid/hid-apple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 5b32fb8c77f3..b37964451a43 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -173,6 +173,7 @@ static const struct apple_key_translation magic_keyboard_2015_fn_keys[] = {
 static const struct apple_key_translation magic_keyboard_2021_and_2024_fn_keys[] = {
 	{ KEY_BACKSPACE, KEY_DELETE },
 	{ KEY_ENTER,	KEY_INSERT },
+	{ KEY_ESC,	KEY_SYSRQ },
 	{ KEY_F1,	KEY_BRIGHTNESSDOWN, APPLE_FLAG_FKEY },
 	{ KEY_F2,	KEY_BRIGHTNESSUP,   APPLE_FLAG_FKEY },
 	{ KEY_F3,	KEY_SCALE,          APPLE_FLAG_FKEY },
-- 
2.56.0

