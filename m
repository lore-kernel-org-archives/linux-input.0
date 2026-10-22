Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664690;
	b=UJwf9AL+afJzBF+ldvfv4Sb789NDiHWEYGCsJtE0BX17212h016UgwLQQ9AieBu2jciT
	 KTG0upjBmSVQDveL6hiRowjB34iGVkoI1hFYJ4L3EpAATeK71sg3ikdHdMr4gznaNA5jW
	 CKnB+6fV4v0R8/jmyRLFX8fTXx0LV9hhniq5I/+Af1QvfAYukP7FgNpTs2IdG2PPVIsGt
	 ssjX722EC1sEcR9STvpOR+e/GMh/4zIdoRjGV4jM5V4BrWzml6INB2fbyz7aII/kwj7Ey
	 tFz0i4gDGMTEbSTHUiFvhxKAPuY2Z8kzxwSfi0Sv7h+FtISW0iz85V1omORWMeJIPwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664690;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding;
	bh=pOK+MsJLB+UOA9uQBG84++ekBGJh1mHJyeB6ZcGJiNE=;
	b=w9trp5OOPRfy98kKvPHzN3cUBNO4kQpbMSXVqhiji9qaEjARuy+TJwcEmeiP5CzoJFQE
	 mNITbEdZ74v8JPH6Fu/I9K1DunjsQ3bD6uPOOgKzjLu989GNoP2R6Q/WzEgRfiicdhAiH
	 778KmPFXciYhhBV9JD7b0PNB6IQersCArx6Ei8E1yITAIahNH3xbsgUNx2W+HFd62J4qE
	 XkZHgXaFk94Mptuig2CNis7EcgImWf2FtoliRu4dySgYVVo7fJZ+HR5Ex7PL7wDkrb2II
	 HICyxS3KJWV0A0Mb8KPzWoc287f11QhyOKktsqGhvymcxBcSavLhQmVU4b8v9m1qGrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DO8xdrbR;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0470606A31A
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 10:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0470606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DO8xdrbR
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48df4e9d2d4so1013348f8f.3
        for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 03:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792664688; x=1793269488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pOK+MsJLB+UOA9uQBG84++ekBGJh1mHJyeB6ZcGJiNE=;
        b=DO8xdrbRO6Eea6fWYSKuYysp+WZj1kNJMGDybTOfWi8vFLXMfg5RgTu6wjntKseX36
         Wc43/g36K8NQ6Edu4M04cd2glQnjNEsg5CPEux5Aq5Z4RJbwkyox0fwH36qpWo7C5/WI
         wLU/VoLeJYNq5tOQfoDKLAXsNmGs/P55VT/uwqA0zvv75oc7ZGWav5n76omrCClJ5Ac5
         uI9MWhoklIhjPwdiR3U0ZkKT8RZuUaCHeIPVnC3KewZuVffnX5j2TYusPcw4fso4i5Gp
         1MoLDePLUqXVOwNC7Ymrrz3v4jtd2MDqgYBq/RZOEV5Ah8rjWB6Ya48AjLuDzEoZe2vg
         adqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792664688; x=1793269488;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pOK+MsJLB+UOA9uQBG84++ekBGJh1mHJyeB6ZcGJiNE=;
        b=tsTM/mB4qziYEywLRzpg/gzgkSbr7hKEITNzsDXQPOBGyt0HR8/PaU7iFAD1KZi2+g
         mNJZ358uRv6UUMUMUQkr1nuh4/Edw94CEhuRVUy+xJQuOa14Tyzb/SV8eHb0UNttyffh
         3QvMucOfjxjckRwtz1kdR3lYHchFWIU/LQya7gSVtTGrcV4OvOY9dNGjiZa3V/uhBNlq
         MrW/ua6S/4C69Hs+y37SSRAaWwCOVB5TvAyQeYJpc64l4+nkFzGP8icCNmZfLg3Shek3
         xjUEgIddexNSTUe8UW/Fw9R8geu+1ZRDYIyJOfXTUypmQnROQ6eudYaxGqYVXAFLkQ0G
         DPPA==
X-Gm-Message-State: AFq9FYJRXOKh9Vlp+lz7ZzhTvAhkwcxY9+7oTojHP4G8YAfEcNpc7REM
	g2fVkIfos2ZqYCUw3gzu0itSpmt1UYMVwlQoVYeJBZNiPSYaIp8ry1vi2mQ1iBwprvI=
X-Gm-Gg: AYBFou2ZvGMmdYG7hq/FxWle+ybl5SpMPKOc6BLGYLIwPq29RDfgNcQo7Lha0apV7eO
	EekkccmUlVJ+XDilg29EPwYNv2WnraeJiH69znxJhY7OtBmcBP3xh9XjY497OjxHyAQvdlogL33
	H5cltX8LN1F1blpnmsy6avYFeM28n10h7Y1zsULmiEn3bTDGb3p/hWOa2JZnCKrDonSiyrzOS3T
	6PHNZq0RKiL85PKVzlOikim5fW1VOYnmI9eaqevXAuLXVFOzh94uBFd6nLJ3p5LdEkNb2gOwZjm
	+buvjXGZIyOnVsP+LNcNrO/7XfAsGJDVAfBFIpGQsMY2vnqpJStORWEJZk/+315F8TdbEQtdWYQ
	q/s5nLOWHGiFCgu0f41VwMNKNn8ATVRPoUDwnqX4oOh0xJD+gYiSfnLIEuSPjthEX/pQK5Yt/+4
	cVHz2O7wIR0aH2OcoPzZBpNc2qfikq9mhMY+e/lXU18exT8uU55fa5E5VetXAJFkn8bjd7Pz4Yg
	fpIn2Mxn6tklBNOXLPwSB3FpQqV/evGiRbGiuDvqwn38i5dDeU3sRD8dMk=
X-Received: by 2002:a05:6000:1801:b0:486:f9ea:796f with SMTP id ffacd0b85a97d-48e264cd778mr6455586f8f.41.1792664687952;
        Thu, 22 Oct 2026 03:24:47 -0700 (PDT)
Received: from [192.168.1.80] ([87.116.133.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25835b1dsm12505216f8f.40.2026.10.22.03.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 03:24:47 -0700 (PDT)
Message-ID: <6bf6c3eb-a142-4f11-92a7-bea7bc715010@gmail.com>
Date: Thu, 22 Oct 2026 12:24:46 +0200
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
From: role <bezrabotni@gmail.com>
Subject: [BUG] TPPS/2 Elan TrackPoint middle/right buttons not reported on
 ThinkPad T14s Gen 2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Subject: [BUG] TPPS/2 Elan TrackPoint middle/right buttons not reported 
on ThinkPad T14s Gen 2

Summary:
On a Lenovo ThinkPad T14s Gen 2, the middle and right buttons of the 
TPPS/2 Elan TrackPoint do not generate any input events at the kernel 
level, while the left button and pointing stick movement work correctly. 
The same hardware works without issues under Windows 11, indicating this 
is a Linux driver initialization or reporting issue, not a hardware fault.

Environment:

     Laptop: Lenovo ThinkPad T14s Gen 2

     Distribution: Fedora Atomic (Sway)

     Kernel: 7.2.9-201.fc44.x86_64

     libinput: libinput-1.31.3-1.fc44.x86_64

     Input device name: TPPS/2 Elan TrackPoint

     Device node: /dev/input/event4

     Bus/Vendor/Product: 0x11 / 0x2 / 0xa

Problem Description:
The kernel input device declares support for BTN_LEFT, BTN_RIGHT, and 
BTN_MIDDLE, but when physically pressing the middle or right button, 
evtest and libinput debug-events only show events for BTN_LEFT and 
REL_X/REL_Y. The middle and right buttons produce no EV_KEY events 
whatsoever.

Evidence:

     - evtest shows the device's declared capabilities include the 
middle and right buttons:

         Event type 1 (EV_KEY)
           Event code 272 (BTN_LEFT)
           Event code 273 (BTN_RIGHT)
           Event code 274 (BTN_MIDDLE)

     - evtest raw output (pressing left button and moving the stick 
produces events; pressing middle/right produces nothing):

         Event: time ..., type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
         Event: time ..., type 2 (EV_REL), code 1 (REL_Y), value 1
         // No BTN_MIDDLE or BTN_RIGHT events observed

     - libinput debug-events also shows no middle/right button events, 
only left button and movement events for event4.

     - libinput quirks list --verbose /dev/input/event4 did not reveal 
any active quirk rules disabling the middle or right buttons.

Attempted Workarounds (all ineffective):
     - Configuring scroll_method on_button_down / scroll_button 
BTN_MIDDLE for the TrackPoint in Sway.
     - Using libinput local-overrides.quirks to try to explicitly enable 
the buttons.
     - Removing the psmouse.synaptics_intertouch=1 kernel parameter 
(currently removed).

Request:
     Please advise whether the psmouse/trackpoint driver has a known 
issue with the Elan TrackPoint on this specific ThinkPad model, or if 
additional debugging information is needed from my side. Since the 
hardware is fully functional under Windows 11, I suspect the driver may 
be failing to properly initialize the TrackPoint's extended button 
functionality during PS/2 protocol negotiation.



Additional information:

uname -r:
     7.2.9-201.fc44.x86_64

cat /proc/version:
     Linux version 7.2.9-201.fc44.x86_64 
(mockbuild@3cc06c60463046bc9e2813f8ad822a95) (gcc (GCC) 16.2.1 20260819 
(Red Hat 16.2.1-2), GNU ld version 2.46.1-1.fc44) #1 SMP PREEMPT_DYNAMIC 
Fri Oct  9 15:04:46 UTC 2026

sudo evtest /dev/input/event4:
     Input driver version is 1.0.1
     Input device ID: bus 0x11 vendor 0x2 product 0xa version 0x63
     Input device name: "TPPS/2 Elan TrackPoint"
     Supported events:
       Event type 0 (EV_SYN)
       Event type 1 (EV_KEY)
         Event code 272 (BTN_LEFT)
         Event code 273 (BTN_RIGHT)
         Event code 274 (BTN_MIDDLE)
       Event type 2 (EV_REL)
         Event code 0 (REL_X)
         Event code 1 (REL_Y)
     Properties:
       Property type 0 (INPUT_PROP_POINTER)
       Property type 5 (INPUT_PROP_POINTING_STICK)
     Testing ... (interrupt to exit)
     Event: time 1792663533.898538, type 1 (EV_KEY), code 272 
(BTN_LEFT), value 1
     Event: time 1792663533.898538, -------------- SYN_REPORT ------------
     Event: time 1792663534.025420, type 1 (EV_KEY), code 272 
(BTN_LEFT), value 0
     Event: time 1792663534.025420, -------------- SYN_REPORT ------------
     Event: time 1792663543.308504, type 2 (EV_REL), code 1 (REL_Y), 
value -1
     Event: time 1792663543.308504, -------------- SYN_REPORT ------------
     Event: time 1792663549.938592, type 2 (EV_REL), code 0 (REL_X), value 1
     Event: time 1792663549.938592, type 2 (EV_REL), code 1 (REL_Y), value 1

sudo libinput debug-events:
     -event5   DEVICE_ADDED                 ELAN0676:00 04F3:3195 Mouse  
      seat0 default group1  cap:p left scroll-nat scroll-button
     -event6   DEVICE_ADDED                 ELAN0676:00 04F3:3195 
Touchpad    seat0 default group1  cap:pg  size 114x58mm tap (dl off) 
left scroll-nat scroll-2fg-edge click-buttonareas-clickfinger dwt-on dwtp-on
     -event7   DEVICE_ADDED                 RAYD0001:00 2386:4B48       
      seat0 default group2  cap:t  size 320x180mm ntouches 10 calib
     -event9   DEVICE_ADDED                 Video Bus            seat0 
default group3  cap:k
     -event10  DEVICE_ADDED                 Intel HID events           
seat0 default group4  cap:k
     -event2   DEVICE_ADDED                 Power Button           seat0 
default group5  cap:k
     -event1   DEVICE_ADDED                 Lid Switch           seat0 
default group6  cap:S
     -event0   DEVICE_ADDED                 Sleep Button           seat0 
default group7  cap:k
     -event3   DEVICE_ADDED                 AT Translated Set 2 
keyboard      seat0 default group8  cap:k
     -event4   DEVICE_ADDED                 TPPS/2 Elan TrackPoint       
     seat0 default group9  cap:p left scroll-nat scroll-button
     -event8   DEVICE_ADDED                 ThinkPad Extra Buttons       
     seat0 default group10 cap:k
     -event4   POINTER_MOTION               +0.000s   -0.31/ -0.31 ( 
-1.00/ -1.00)
      event4   POINTER_MOTION            2  +0.009s   -9.41/ -9.41 ( 
-3.00/ -3.00)
      event4   POINTER_MOTION            3  +0.019s   -5.55/ -8.32 ( 
-2.00/ -3.00)
      event4   POINTER_MOTION            4  +0.029s   -4.51/ -4.51 ( 
-2.00/ -2.00)
      event4   POINTER_MOTION            5  +0.049s   -0.80/ -0.80 ( 
-1.00/ -1.00)
      event4   POINTER_MOTION            6  +0.058s    0.00/ -1.00 ( 
+0.00/ -1.00)
      event4   POINTER_MOTION            7  +0.068s    0.00/  1.00 ( 
+0.00/ +1.00)
      event4   POINTER_BUTTON               +1.889s  BTN_LEFT (272) 
pressed, seat count: 1
      event4   POINTER_BUTTON               +2.026s  BTN_LEFT (272) 
released, seat count: 0

sudo dmesg | grep -i -E "psmouse|trackpoint|elan|input":
     [    0.712414] input: Sleep Button as 
/devices/platform/PNP0C0E:00/input/input0
     [    0.712517] input: Lid Switch as 
/devices/platform/PNP0C0D:00/input/input1
     [    0.712535] input: Power Button as 
/devices/platform/LNXPWRBN:00/input/input2
     [    1.007578] input: AT Translated Set 2 keyboard as 
/devices/platform/i8042/serio0/input/input3
     [    1.284865] psmouse serio1: trackpoint: Elan TrackPoint 
firmware: 0xa1, buttons: 3/3
     [    1.309768] input: TPPS/2 Elan TrackPoint as 
/devices/platform/i8042/serio1/input/input5
     [    2.160064] input: ELAN0676:00 04F3:3195 Mouse as 
/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-ELAN0676:00/0018:04F3:3195.0001/input/input6
     [    2.160228] input: ELAN0676:00 04F3:3195 Touchpad as 
/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-ELAN0676:00/0018:04F3:3195.0001/input/input8
     [    2.160285] hid-generic 0018:04F3:3195.0001: input,hidraw0: I2C 
HID v1.00 Mouse [ELAN0676:00 04F3:3195] on i2c-ELAN0676:00
     [    2.232543] input: RAYD0001:00 2386:4B48 Touchscreen as 
/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-RAYD0001:00/0018:2386:4B48.0002/input/input9
     [    2.232641] hid-generic 0018:2386:4B48.0002: input,hidraw1: I2C 
HID v1.00 Device [RAYD0001:00 2386:4B48] on i2c-RAYD0001:00
     [    2.356491] input: ELAN0676:00 04F3:3195 Mouse as 
/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-ELAN0676:00/0018:04F3:3195.0001/input/input11
     [    2.356652] input: ELAN0676:00 04F3:3195 Touchpad as 
/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-ELAN0676:00/0018:04F3:3195.0001/input/input13
     [    2.356803] hid-multitouch 0018:04F3:3195.0001: input,hidraw0: 
I2C HID v1.00 Mouse [ELAN0676:00 04F3:3195] on i2c-ELAN0676:00
     [    2.388505] input: RAYD0001:00 2386:4B48 as 
/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-RAYD0001:00/0018:2386:4B48.0002/input/input14
     [    2.388562] hid-multitouch 0018:2386:4B48.0002: input,hidraw1: 
I2C HID v1.00 Device [RAYD0001:00 2386:4B48] on i2c-RAYD0001:00
     [    2.520171] input: ThinkPad Extra Buttons as 
/devices/platform/thinkpad_acpi/input/input16
     [    3.057098] input: Video Bus as 
/devices/pci0000:00/acpi.video_bus.0/input/input17
     [   87.858014] input: Intel HID events as 
/devices/platform/INTC1051:00/input/input18
     [   88.311777] input: PC Speaker as 
/devices/platform/pcspkr/input/input19
     [   91.694203] snd_hda_codec_alc269 ehdaudio0D0:    inputs:
     [   91.767147] input: sof-hda-dsp Mic as 
/devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input20
     [   91.767353] input: sof-hda-dsp Headphone as 
/devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input21
     [   91.767490] input: sof-hda-dsp HDMI/DP,pcm=3 as 
/devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input22
     [   91.767646] input: sof-hda-dsp HDMI/DP,pcm=4 as 
/devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input23
     [   91.767802] input: sof-hda-dsp HDMI/DP,pcm=5 as 
/devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/input24

cat /sys/class/dmi/id/modalias:
dmi:bvnLENOVO:bvrN35ET66W(1.66):bd05/18/2026:br1.66:efr1.46:svnLENOVO:pn20WNS1B010:pvrThinkPadT14sGen2i:rvnLENOVO:rn20WNS1B010:rvrSDK0J40697WIN:cvnLENOVO:ct10:cvrNone:skuLENOVO_MT_20WN_BU_Think_FM_ThinkPadT14sGen2i:pfaThinkPadT14sGen2i:


Best Regards,

Robert

