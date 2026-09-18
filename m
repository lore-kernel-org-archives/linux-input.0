Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C29C343D85
	for <linux-input@vger.kernel.org>; Fri, 18 Sep 2026 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692160; cv=none; b=sn3xu5jSUKK81h+O6kUenvONg9v3YCQfdLTfm0+Pkytc0MUJr5lYKSXYOcUpI1kMhyQLd2YgETYFLclCt5XpCAeVcSlgRHppdbM7tW18QmaVoNQQA/IBnhZKT5O1c0V4orTiLUqMW8POTodEcRBlmT5SuivaXBVAC9Ac5ELIK1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692160; c=relaxed/simple;
	bh=ILg/bneehXBTD5aCcbwNLKfpno4vOSbUcrgQFJDM5LI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=FIkX16QBaq4QvRwoQMZRyhCOFMSPWRC5NRdvHGJOeYAAqZOah2nKYrKKSJ4fxNvDH806JKcX7XOppmi/v0sMJQGFwmEwM3wrnzvnvVeyASWnudo2bFdwzGFGXCOW7/vEAQ1LXoI9+V2KrOCPejifZEzp/Zej3JddItCCBnVRsew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShPCaEwS; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShPCaEwS"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd4b43b20bso1134185ad.1
        for <linux-input@vger.kernel.org>; Thu, 17 Sep 2026 17:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789692155; x=1790296955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=soGokKBguWVTgJCT+2E4vj0CUHCJEzgVeS283OEsOLg=;
        b=ShPCaEwSVPhMK/0+vuRIt51ymGNHKTxM79v1RcBnBLTwCuL+4zNKXolHzW7z4TiG92
         3MwC7ytoZBbCP1X6F6RDPKCINSL8+74/onkz8nlTcpLLyazHxsMZBzIJ4ZnJ1M7cptx2
         j2SS95/3k+0h0DRCT0aAxJRvbhf8lzsqaUtJZQe65NpIgWMp9isuRPYg33LumkVr21pz
         O1yhDuwC8JRsbshaUSvJHIGu5eQJH3X8FelGRtzE0wm+ti0fxOoCnFE61YNHDHI4DR0F
         uWINbt91lk//KgKQmaMfJzc7/8/U4K3K5jm/D2bfDTUE9zcHFoiVwzuiv2bN7txa1FcV
         C+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789692155; x=1790296955;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=soGokKBguWVTgJCT+2E4vj0CUHCJEzgVeS283OEsOLg=;
        b=HyqVUyks6wur9LcnYLxbZ0gVrJPI3avhxNmDMCo+FoqClLV0OYfQKSKLZjVdp8nNxl
         6asdVlBuAhskO8/7O/qNkfMSM3yurZ6aKDm/YJyfjHxZnM/m8orR+6BX6jEnClHPZaCN
         zGGCscTsL7IHyzAV2yLkg30vPvicvkI/K5PMTH9b7QegoIRoj1BOMSnRfz/oP9MMPg/y
         S+bgmeNMWh9odFN6wPwDn1VLXnuQBh3+jE4RSMynWoLSN77lYI1D+Efq3HPx8STN95X7
         gC5Xu6ATWml5HD74NH6/G2WN29pE4UcoDuaJHwJE16pqU4OC2TFVHDJh9zOMB98kjcht
         uchw==
X-Forwarded-Encrypted: i=1; AKwUvBz+CC23FL2xV3EsjGZKGXnCkwKMTrY6ThA9nz4iYQLes+4Gm86efXeAdT4ewubhvBzpVr/G3M6IGD1WBw==@vger.kernel.org
X-Gm-Message-State: AFuF++kAxUKyBxt0hGDHoXKUwhtwSdhFmrZ1DrvaJYJZCMI1rk6+Tdl+
	uLJPTMzL/KEhCxYjdDY4sDWg3OB91yVc7F76VBf3aJRx2LqbtdsYUp2l5+BEjQ==
X-Gm-Gg: AYBFou3VW6cdGIuygHWsioBqa6a0RJYrhSk43UH9CyDcZVW/qOJRuMPwWOwoCV42yml
	z/yBwmBBMc0OcmGBdPY+YGwXTC/OXhm95N2elib4aNzrELzIoqAcvGzeUsoqq9D8QcprTqr0NjZ
	IFPyL804bM8nmDbBqBZVw8kFfj+D/aqd2AZXXAmMXCZ9QpF9PIzokgipo4pvfHSzbxBHUGbZa24
	u+PEdWD0QNBuQ//56BRxUNj3J9eIxnDjQ1JoktQykAlwVehP2YQBW3yeXL5OYAotOrwKLHJ5KK1
	olMNP5kw4DGt2qmbY1Nyvz+SjVeIYMSOYuNc9/HV48pt9veQhYJs2/uyjcVW66/IszeI6vv452L
	Sb8tYwCKKsMytfYHTBvmtvKg7XTI/CcCAJmJansAZXyE7Q33AN7r4BrcvOqY84TWYj6V8BScy9e
	nabotb9si/F/75WTfsbQxXsoKHE+ZcjTBhWNrQ6yNikBJm2gxRTmY8qUO9II7QAcbZyjFH6O+CH
	lJZhjUf7nDlXeeiAaGh4mbe62q07woPARXV8AGyy9l/Fj6cSI0nrmGLQWTbJUOFU8zM4gPuJmzH
	AcTZ
X-Received: by 2002:a17:90b:4405:b0:39e:4c80:f681 with SMTP id 98e67ed59e1d1-39e54f430c9mr1652018a91.32.1789692155097;
        Thu, 17 Sep 2026 17:42:35 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a6a182sm19835592eec.8.2026.09.17.17.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 17:42:34 -0700 (PDT)
Date: Thu, 17 Sep 2026 17:42:31 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Antheas Kapenekakis <lkml@antheas.dev>,
 =?ISO-8859-1?Q?Mat=EDas_Mart=EDnez?= <hello@matias.me>
CC: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Denis Benato <denis.benato@linux.dev>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v3] HID: ayaneo: Add AYANEO 3 detachable controller driver
User-Agent: Thunderbird for Android
In-Reply-To: <CAGwozwEkgP9-VwhW81=WEvJOac5iD+PFO4tA4eVrFP_qDVaiWA@mail.gmail.com>
References: <20260824223103.93947-1-hello@matias.me> <20260917160722.89391-1-hello@matias.me> <CAGwozwEkgP9-VwhW81=WEvJOac5iD+PFO4tA4eVrFP_qDVaiWA@mail.gmail.com>
Message-ID: <F96DE6B8-1866-42FA-BA13-1F97B8E64733@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On September 17, 2026 2:48:11 PM PDT, Antheas Kapenekakis <lkml@antheas=2Ed=
ev> wrote:
>On Thu, 17 Sept 2026 at 18:07, Mat=C3=ADas Mart=C3=ADnez <hello@matias=2E=
me> wrote:
>>
>> From: Mati=CC=81as Marti=CC=81nez <hello@matias=2Eme>
>
>Hi Matias,
>
>> The AYANEO 3 handheld has a detachable controller with swappable
>> modules ("Magic Modules")=2E The controller exposes three USB HID
>> interfaces behind 1c4f:0002 (a generic SigmaMicro VID/PID, hence the
>> DMI gate): a gamepad, a keyboard for the extra buttons, and a vendor
>> interface accepting 65-byte commands=2E
>>
>> Add a driver for the vendor interface providing module identification
>> (module_left/module_right sysfs attributes), software eject of the
>> modules (eject sysfs attribute, blocking until the firmware confirms
>> the release handshake), and RGB control of the joystick rings as a
>> multicolor LED class device ("<device name>:rgb:joystick_rings";
>> userspace such as InputPlumber matches the function suffix)=2E The
>> firmware's fixed breathing pattern is exposed through the hw_pattern
>> trigger ABI=2E
>>
>> This complements the ayaneo-ec platform driver, which exposes module
>> attach state and controller power=2E A full physical eject is performed
>> by writing to eject and then cutting power through ayaneo-ec's
>> controller_power attribute; that orchestration is deliberately left
>> to userspace=2E
>>
>> The protocol was reverse engineered in the Handheld Daemon project by
>> Antheas Kapenekakis=2E Tested on an AYANEO 3: module identification,
>> RGB solid and breathing, a full eject/reinsert/repower cycle, and
>> repeated driver unbinds under a concurrent brightness-write load=2E
>> Signed-off-by: Mati=CC=81as Marti=CC=81nez <hello@matias=2Eme>
>> Reviewed-by: Denis Benato <denis=2Ebenato@linux=2Edev>
>> ---
>> Changes in v3:
>> - Use a generic ayaneo_ prefix for entry points and driver structure
>>   so a future device or protocol revision slots in without churn;
>>   wire-protocol constants stay AYA3_* since they are specific to
>>   this firmware generation=2E [Derek J=2E Clark]
>> - Describe the wire format with packed aya3_config/aya3_resp structs,
>>   static_assert their sizes against the report sizes, and name every
>>   firmware vibration level in an enum instead of a lone default
>>   define=2E [Derek J=2E Clark]
>> - Take the command lock with scoped_cond_guard(mutex_intr, =2E=2E=2E) a=
t
>>   every interruptible lock site so the unlock cannot be dropped in a
>>   future edit=2E [Derek J=2E Clark]
>> - Mark the LED class device LED_COLOR_ID_RGB so userspace can detect
>>   the RGB interface generically=2E [Derek J=2E Clark]
>> - Name the firmware timing constants and record where the timings
>>   come from and what was validated on hardware=2E
>>
>> No functional change relative to v2=2E The rework was prompted by
>> Derek J=2E Clark's review of the driver in the OpenGamingCollective
>> tree and retested on an AYANEO 3: module identification, RGB solid
>> and breathing via hw_pattern, rejection of malformed hw_pattern
>> writes, and repeated bind/unbind cycles, all with a clean dmesg=2E
>>
>> One question from that review was whether RGB sysfs writes need
>> debouncing, since Steam emits one write per slider increment during
>> a color drag=2E They do not: the driver registers only
>> brightness_set_blocking, so the LED core defers stores to its
>> set_brightness_work and coalesces bursts to the latest state=2E
>> Measured on hardware, a command+ACK round trip averages 5=2E3 ms
>> (3=2E8-8 ms over 100 samples) and 1000 back-to-back multi_intensity
>> stores return in 12 ms total, reaching the device as two to three
>> commands=2E
>
>After you submitted your patch series to the lore, why didn't the
>review take place here and take place downstream? I understand that
>prior to submitting your first kernel patch, it is natural to get some
>informal feedback, but it seems that all of the reviews of this driver
>happened outside the submission and after the submission? The rby
>Denis should not be added by you=2E It should be added by denis by
>replying to the mailing list and then you carry it forward on future
>revisions (for provenance)=2E
>
>If you are developing a downstream kernel patch for
>OGC/Bazzite/whoever, it is perfectly fine to do downstream work and
>reviews and only submit the driver after it is ready=2E In fact, it
>would be very preferable for all of us for you to test your driver
>downstream, resolve all feedback and then submit it when it's ready=2E
>But mixing this is peculiar=2E This is not a comment on you, you were
>not the one reviewing your patch out of band=2E

Antheas,

There is no reason to throw shade about the process=2E This was submitted =
to OGC unstable prior to v1 where Denis reviewed and tagged it prior to it =
being submitted=2E I wasn't Cc'd or informed that it was already on a v2 le=
ss than 48h later, so I submitted my feedback directly on the PR a couple d=
ays later=2E Had I been aware I would have obviously submitted feedback her=
e=2E Without your feedback necessary we've already implemented better contr=
ol policies to avoid this in the future=2E

Thanks,
Derek

>> Also suggested in that review, but held out of the patch while the
>> driver's scope is under discussion: a rumble_intensity attribute
>> (the firmware takes three vibration levels), an eject_index
>> attribute, and a notification path from hid-ayaneo to ayaneo-ec so
>> the EC driver could react to ejects=2E The last one concerns the
>> ayaneo-ec/pdx86 side, hence the added Cc=2E
>>
>> Changes in v2:
>> - Unregister the LED class device before tearing down the HID
>>   transport, and flush a late-queued brightness work item that can
>>   race the unregister; the work could otherwise run against freed
>>   memory=2E Found by stress-testing rmmod under a brightness-write
>>   loop; also reachable whenever the controller power-cycles (resume,
>>   module eject) while userspace writes the LED=2E [sashiko, Denis]
>> - Abort the eject wait as soon as the transport reports a fatal
>>   error instead of polling for up to 8 seconds=2E [sashiko]
>> - Reject report descriptors with no collections explicitly=2E [sashiko]
>> - Document why a late reply to a timed-out command is harmless=2E
>>   [sashiko]
>> - Stop writing the joystick-sensitivity bytes in the config command
>>   so RGB updates no longer clobber the firmware setting; verified on
>>   hardware that RGB and eject work without them=2E [Antheas]
>> - Expose the firmware's breathing mode through the hw_pattern
>>   trigger ABI, with an ABI document=2E [Antheas]
>>
>>  =2E=2E=2E/testing/sysfs-class-led-driver-hid-ayaneo |  15 +
>>  =2E=2E=2E/ABI/testing/sysfs-driver-hid-ayaneo       |  36 ++
>>  MAINTAINERS                                   |   8 +
>>  drivers/hid/Kconfig                           |  14 +
>>  drivers/hid/Makefile                          |   1 +
>>  drivers/hid/hid-ayaneo=2Ec                      | 594 ++++++++++++++++=
++
>>  6 files changed, 668 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-hi=
d-ayaneo
>>  create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-ayaneo
>>  create mode 100644 drivers/hid/hid-ayaneo=2Ec
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-driver-hid-ayane=
o b/Documentation/ABI/testing/sysfs-class-led-driver-hid-ayaneo
>> new file mode 100644
>> index 000000000=2E=2E00f100dba
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-led-driver-hid-ayaneo
>> @@ -0,0 +1,15 @@
>> +What:          /sys/class/leds/<led>/hw_pattern
>
>Consider exploring similar ABIs in e=2Eg=2E, Legion Go S hid and mirrorin=
g
>their ABI=2E Then remove this file=2E This is not the only breathing
>device=2E Moreover, delta_t values are ignored and you are introducing
>an ABI for them? Prefer a mode setting that can be standard/breathing
>mirroring a different driver=2E
>
>> +Date:          August 2026
>> +KernelVersion: 7=2E3
>> +Contact:       Mat=C3=ADas Mart=C3=ADnez <hello@matias=2Eme>
>> +Description:
>> +               Specify a hardware pattern for the AYANEO 3 joystick
>> +               rings LED=2E The firmware supports a single breathing
>> +               pattern, pulsing the current colour at a fixed,
>> +               firmware-controlled period:
>> +
>> +               "0 <t> <brightness> <t>"
>> +
>> +               Both delta_t values are accepted but ignored, as the
>> +               period is not configurable=2E <brightness> must be
>> +               non-zero=2E Any other pattern is rejected=2E
>> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-ayaneo b/Docume=
ntation/ABI/testing/sysfs-driver-hid-ayaneo
>> new file mode 100644
>> index 000000000=2E=2E807c4fc9d
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-hid-ayaneo
>> @@ -0,0 +1,36 @@
>> +What:          /sys/bus/hid/drivers/hid-ayaneo/<dev>/module_left
>> +What:          /sys/bus/hid/drivers/hid-ayaneo/<dev>/module_right
>> +Date:          August 2026
>> +KernelVersion: 7=2E3
>> +Contact:       Mat=C3=ADas Mart=C3=ADnez <hello@matias=2Eme>
>> +Description:
>> +               Reports the type of the module currently inserted in th=
e
>> +               left/right slot of the AYANEO 3 detachable controller, =
as
>> +               the raw identifier reported by the controller firmware =
in
>> +               hexadecimal (e=2Eg=2E "0x04")=2E Bits 0-5 encode the mo=
dule
>> +               type, bit 6 indicates the module is inserted rotated=2E
>> +
>> +               Reading these attributes queries the controller and can
>> +               take up to a second=2E
>> +
>> +What:          /sys/bus/hid/drivers/hid-ayaneo/<dev>/eject
>> +Date:          August 2026
>> +KernelVersion: 7=2E3
>> +Contact:       Mat=C3=ADas Mart=C3=ADnez <hello@matias=2Eme>
>> +Description:
>> +               Write-only=2E Writing "left", "right" or "both" asks th=
e
>> +               controller firmware to release the corresponding
>> +               module(s)=2E The write blocks until the firmware confir=
ms
>> +               the release handshake (typically a few seconds)=2E The
>> +               module is physically released once controller power is
>> +               subsequently cut through the ayaneo-ec platform driver'=
s
>> +               controller_power attribute; that final step is left to
>> +               userspace=2E
>> +
>> +What:          /sys/bus/hid/drivers/hid-ayaneo/<dev>/reset
>> +Date:          August 2026
>> +KernelVersion: 7=2E3
>> +Contact:       Mat=C3=ADas Mart=C3=ADnez <hello@matias=2Eme>
>> +Description:
>> +               Write-only=2E Writing "1" asks the controller firmware =
to
>> +               perform a quick reset of the controller configuration=
=2E
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8b14f290c=2E=2E3290d9957 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -4508,6 +4508,14 @@ F:       Documentation/devicetree/bindings/spi/a=
xiado,ax3000-spi=2Eyaml
>>  F:     drivers/spi/spi-axiado=2Ec
>>  F:     drivers/spi/spi-axiado=2Eh
>>
>> +AYANEO 3 CONTROLLER HID DRIVER
>> +M:     Mat=C3=ADas Mart=C3=ADnez <hello@matias=2Eme>
>> +L:     linux-input@vger=2Ekernel=2Eorg
>> +S:     Maintained
>> +F:     Documentation/ABI/testing/sysfs-class-led-driver-hid-ayaneo
>> +F:     Documentation/ABI/testing/sysfs-driver-hid-ayaneo
>> +F:     drivers/hid/hid-ayaneo=2Ec
>> +
>>  AYANEO PLATFORM EC DRIVER
>>  M:     Antheas Kapenekakis <lkml@antheas=2Edev>
>>  L:     platform-driver-x86@vger=2Ekernel=2Eorg
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 0e3a0ccd6=2E=2E319eda887 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -205,6 +205,20 @@ config HID_AUREAL
>>         help
>>         Support for Aureal Cy se W-01RN Remote Controller and other Aur=
eal derived remotes=2E
>>
>> +config HID_AYANEO
>> +       tristate "AYANEO 3 detachable controller support"
>> +       depends on USB_HID
>> +       depends on DMI
>> +       depends on LEDS_CLASS_MULTICOLOR
>> +       help
>> +         Provides support for the detachable controller ("Magic Module=
s")
>> +         of the AYANEO 3 handheld: module identification, software eje=
ct
>> +         and RGB control of the joystick rings=2E Complements the ayan=
eo-ec
>> +         platform driver, which handles module attach state and contro=
ller
>> +         power=2E
>> +
>> +         Say Y or M here if you have an AYANEO 3=2E
>> +
>>  config HID_BELKIN
>>         tristate "Belkin Flip KVM and Wireless keyboard"
>>         help
>> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
>> index 79384d905=2E=2E2f74f2867 100644
>> --- a/drivers/hid/Makefile
>> +++ b/drivers/hid/Makefile
>> @@ -35,6 +35,7 @@ obj-$(CONFIG_HID_APPLETB_KBD) +=3D hid-appletb-kbd=2E=
o
>>  obj-$(CONFIG_HID_CREATIVE_SB0540)      +=3D hid-creative-sb0540=2Eo
>>  obj-$(CONFIG_HID_ASUS)         +=3D hid-asus=2Eo
>>  obj-$(CONFIG_HID_AUREAL)       +=3D hid-aureal=2Eo
>> +obj-$(CONFIG_HID_AYANEO)       +=3D hid-ayaneo=2Eo
>>  obj-$(CONFIG_HID_BELKIN)       +=3D hid-belkin=2Eo
>>  obj-$(CONFIG_HID_BETOP_FF)     +=3D hid-betopff=2Eo
>>  obj-$(CONFIG_HID_BIGBEN_FF)    +=3D hid-bigbenff=2Eo
>> diff --git a/drivers/hid/hid-ayaneo=2Ec b/drivers/hid/hid-ayaneo=2Ec
>> new file mode 100644
>> index 000000000=2E=2E3a7af5918
>> --- /dev/null
>> +++ b/drivers/hid/hid-ayaneo=2Ec
>> @@ -0,0 +1,594 @@
>> +// SPDX-License-Identifier: GPL-2=2E0+
>> +/*
>> + * HID driver for the AYANEO 3 detachable controller ("Magic Modules")=
=2E
>> + *
>> + * The AYANEO 3 controller exposes three USB HID interfaces behind
>> + * VID 0x1c4f PID 0x0002 (a generic SigmaMicro ID, hence the DMI gate)=
:
>> + * a gamepad, a keyboard for the extra buttons, and a vendor interface
>> + * (application usage 0xff000001) accepting 65-byte commands=2E
>> + *
>> + * This driver binds the vendor interface and provides:
>> + *  - module identification (which module type is inserted on each sid=
e)
>> + *  - software eject of the left/right modules
>> + *  - RGB control of the joystick rings as a multicolor LED class devi=
ce
>> + *
>> + * It complements the ayaneo-ec platform driver, which exposes module
>> + * attach state and controller power=2E A full eject is: write to this
>> + * driver's "eject" attribute, then power the controller off through
>> + * ayaneo-ec's controller_power once the eject completes=2E
>> + *
>> + * The protocol was reverse engineered in the Handheld Daemon project =
by
>> + * Antheas Kapenekakis=2E
>> + *
>> + * Command format (65 bytes, unnumbered report):
>> + *   [0]   report id (0)
>> + *   [1:3] little-endian sum of bytes 7=2E=2E64
>> + *   [3]   command
>> + *   [4]   subcommand
>> + *   [5:]  payload
>> + * The device replies with a 64-byte report echoing the subcommand at
>> + * byte 3=2E
>> + *
>> + * Copyright (C) 2026 Mat=C3=ADas Mart=C3=ADnez <hello@matias=2Eme>
>> + */
>> +
>> +#include <linux/build_bug=2Eh>
>> +#include <linux/cleanup=2Eh>
>> +#include <linux/delay=2Eh>
>> +#include <linux/dmi=2Eh>
>> +#include <linux/hid=2Eh>
>> +#include <linux/led-class-multicolor=2Eh>
>> +#include <linux/module=2Eh>
>> +#include <linux/mutex=2Eh>
>> +#include <linux/sysfs=2Eh>
>> +#include <linux/unaligned=2Eh>
>> +#include <linux/workqueue=2Eh>
>> +
>> +#define AYA3_REPORT_SIZE       65
>> +#define AYA3_RESP_SIZE         64
>> +
>> +/*
>> + * Empirical timings, inherited from the Handheld Daemon
>> + * implementation of this protocol and validated on hardware: the
>> + * device answers well within 300ms or not at all, needs about half
>> + * a second to settle after a reset before it accepts a new
>> + * configuration, and completes an eject handshake within a few
>> + * seconds (polled below at a rate that keeps the sysfs write
>> + * responsive)=2E
>> + */
>> +#define AYA3_CMD_TIMEOUT_MS    300
>> +#define AYA3_CMD_ATTEMPTS      3
>> +#define AYA3_RESET_SETTLE_MS   500
>> +#define AYA3_EJECT_POLL_MS     400
>> +#define AYA3_EJECT_POLLS       20
>> +
>> +/* Subcommands (byte 4); byte 3 is 0x00 except for the config command =
*/
>> +#define AYA3_SUBCMD_CHECK      0x08
>> +#define AYA3_CMD_CONFIG                0x21
>> +#define AYA3_SUBCMD_CONFIG     0x09
>> +
>> +/* Bits that stay set in the eject status byte after an eject complete=
s */
>> +#define AYA3_EJECT_DONE_MASK   0x11
>> +
>> +/* Config command eject/reset field */
>> +#define AYA3_EJECT_LEFT                0x07
>> +#define AYA3_EJECT_RIGHT       0x70
>> +#define AYA3_RESET             0x88
>> +
>> +/* Config command RGB modes */
>> +#define AYA3_RGB_SOLID         0x01
>> +#define AYA3_RGB_PULSE         0x02
>> +#define AYA3_RGB_OFF           0xff
>> +
>> +/* Config command vibration levels, stored in the high nibble */
>> +enum aya3_vibration {
>> +       AYA3_VIBRATION_LOW      =3D 0x1,
>> +       AYA3_VIBRATION_MEDIUM   =3D 0x2,
>> +       AYA3_VIBRATION_HIGH     =3D 0x3,
>> +       AYA3_VIBRATION_OFF      =3D 0x4,
>> +};
>> +
>> +struct aya3_rgb {
>> +       u8 mode;
>> +       u8 r;
>> +       u8 g;
>> +       u8 b;
>> +} __packed;
>> +
>> +/*
>> + * The 65-byte config command=2E The checksum is the little-endian sum=
 of
>> + * bytes 7=2E=2E64; unk* fields are sent as zero=2E
>> + */
>> +struct aya3_config {
>> +       u8 report_id;
>> +       __le16 csum;
>> +       u8 cmd;
>> +       u8 subcmd;
>> +       u8 unk5[3];
>> +       struct aya3_rgb right;
>> +       struct aya3_rgb left;
>> +       u8 unk16[4];
>> +       u8 eject;
>> +       u8 unk21;
>> +       u8 sensitivity[2];
>> +       u8 vibration;
>> +       u8 unk25[7];
>> +       u8 magic;
>> +       u8 unk33[32];
>
>I am not sure of the struct naming or whether a struct is needed in
>this case=2E if you do not use most of the report, consider documenting
>it somewhere else and doing direct accesses to the appropriate bytes=2E
>
>> +} __packed;
>> +static_assert(sizeof(struct aya3_config) =3D=3D AYA3_REPORT_SIZE);
>> +
>> +/* Replies echo the subcommand they answer at byte 3 */
>> +struct aya3_resp {
>> +       u8 unk0[3];
>> +       u8 subcmd;
>> +       u8 unk4[15];
>> +       u8 eject_status;
>> +       u8 unk20[12];
>> +       u8 module_left;
>> +       u8 module_right;
>> +       u8 unk34[30];
>> +} __packed;
>> +static_assert(sizeof(struct aya3_resp) =3D=3D AYA3_RESP_SIZE);
>> +
>> +struct ayaneo {
>> +       struct hid_device *hdev;
>> +       /* DMA-safe command buffer; guarded by lock */
>> +       u8 *xfer;
>> +       /* Serializes commands and cached-config access */
>> +       struct mutex lock;
>> +       struct completion resp_done;
>> +       struct aya3_resp resp;
>> +       u8 resp_expect;
>> +       bool resp_pending;
>> +
>> +       u8 rgb[3];
>> +       bool pulse;
>> +       u8 vibration;
>> +
>> +       struct led_classdev_mc mcled;
>> +       struct mc_subled subleds[3];
>> +};
>> +
>> +static int ayaneo_send(struct ayaneo *aya)
>> +{
>> +       int ret;
>> +
>> +       ret =3D hid_hw_output_report(aya->hdev, aya->xfer, AYA3_REPORT_=
SIZE);
>> +       if (ret =3D=3D -ENOSYS)
>> +               ret =3D hid_hw_raw_request(aya->hdev, aya->xfer[0], aya=
->xfer,
>> +                                        AYA3_REPORT_SIZE, HID_OUTPUT_R=
EPORT,
>> +                                        HID_REQ_SET_REPORT);
>> +       if (ret < 0)
>> +               return ret;
>> +       return 0;
>> +}
>> +
>> +/**
>> + * ayaneo_cmd() - send the command in aya->xfer and wait for the reply
>> + * @aya: driver data; @aya->xfer holds the fully built 65-byte command
>> + * @resp: destination for the reply, or NULL to discard it
>> + *
>> + * The device echoes the subcommand byte of the command it is answerin=
g,
>> + * which ayaneo_raw_event() uses to match replies=2E Unanswered comman=
ds are
>> + * retried up to AYA3_CMD_ATTEMPTS times=2E
>> + *
>> + * Context: process context; the caller must hold @aya->lock, which
>> + *          protects @aya->xfer and the reply state=2E
>> + * Return: 0 on success, -ETIMEDOUT if every attempt went unanswered, =
or
>> + *         a negative errno if sending failed=2E
>> + */
>> +static int ayaneo_cmd(struct ayaneo *aya, struct aya3_resp *resp)
>> +{
>> +       int attempt, ret;
>> +
>> +       lockdep_assert_held(&aya->lock);
>> +
>> +       for (attempt =3D 0; attempt < AYA3_CMD_ATTEMPTS; attempt++) {
>> +               reinit_completion(&aya->resp_done);
>> +               aya->resp_expect =3D aya->xfer[4];
>> +               WRITE_ONCE(aya->resp_pending, true);
>> +
>> +               ret =3D ayaneo_send(aya);
>> +               if (ret) {
>> +                       WRITE_ONCE(aya->resp_pending, false);
>> +                       return ret;
>> +               }
>> +
>> +               if (wait_for_completion_timeout(&aya->resp_done,
>> +                                               msecs_to_jiffies(AYA3_C=
MD_TIMEOUT_MS))) {
>> +                       if (resp)
>> +                               memcpy(resp, &aya->resp, sizeof(*resp))=
;
>> +                       return 0;
>> +               }
>> +       }
>> +       WRITE_ONCE(aya->resp_pending, false);
>> +       return -ETIMEDOUT;
>> +}
>> +
>> +static void ayaneo_checksum(u8 *buf)
>> +{
>> +       u16 sum =3D 0;
>> +       int i;
>> +
>> +       for (i =3D 7; i < AYA3_REPORT_SIZE; i++)
>> +               sum +=3D buf[i];
>> +       put_unaligned_le16(sum, buf + 1);
>> +}
>> +
>> +static int ayaneo_check(struct ayaneo *aya, struct aya3_resp *resp)
>> +{
>> +       memset(aya->xfer, 0, AYA3_REPORT_SIZE);
>> +       aya->xfer[4] =3D AYA3_SUBCMD_CHECK;
>> +       return ayaneo_cmd(aya, resp);
>> +}
>> +
>> +/*
>> + * The config command sets everything at once: RGB for both rings,
>> + * vibration strength and the eject/reset field=2E The command can als=
o
>> + * carry joystick sensitivity; those bytes are left zero so the
>> + * firmware setting is not clobbered on every RGB update=2E
>> + */
>> +static int ayaneo_send_config(struct ayaneo *aya, u8 eject)
>> +{
>> +       static const struct aya3_config template =3D {
>> +               =2Ecmd =3D AYA3_CMD_CONFIG,
>> +               =2Esubcmd =3D AYA3_SUBCMD_CONFIG,
>> +               =2Emagic =3D 0x01,
>> +       };
>> +       struct aya3_config *cfg =3D (struct aya3_config *)aya->xfer;
>> +       u8 mode =3D AYA3_RGB_OFF;
>> +
>> +       if (aya->rgb[0] || aya->rgb[1] || aya->rgb[2])
>> +               mode =3D aya->pulse ? AYA3_RGB_PULSE : AYA3_RGB_SOLID;
>> +
>> +       *cfg =3D template;
>> +       cfg->right=2Emode =3D mode;
>> +       cfg->right=2Er =3D aya->rgb[0];
>> +       cfg->right=2Eg =3D aya->rgb[1];
>> +       cfg->right=2Eb =3D aya->rgb[2];
>> +       cfg->left =3D cfg->right;
>> +       cfg->eject =3D eject;
>> +       cfg->vibration =3D aya->vibration << 4;
>
>If you set vibration, you need to expose it to userspace=2E Otherwise
>this driver degrades functionality over userspace implementations=2E
>
>> +       ayaneo_checksum(aya->xfer);
>> +
>> +       return ayaneo_cmd(aya, NULL);
>> +}
>> +
>> +static int ayaneo_raw_event(struct hid_device *hdev, struct hid_report=
 *report,
>> +                           u8 *data, int size)
>> +{
>> +       struct ayaneo *aya =3D hid_get_drvdata(hdev);
>> +       const struct aya3_resp *resp =3D (const struct aya3_resp *)data=
;
>> +
>> +       if (!READ_ONCE(aya->resp_pending) || size < AYA3_RESP_SIZE)
>> +               return 0;
>> +       /*
>> +        * Replies carry no sequence number, only the subcommand echo=
=2E A
>> +        * late reply to a timed-out command can thus complete a newer
>> +        * command with the same subcommand; such replies are snapshots
>> +        * of the same query milliseconds apart, so this is harmless=2E
>> +        * Replies to a different subcommand are dropped here=2E
>> +        */
>> +       if (resp->subcmd !=3D aya->resp_expect)
>> +               return 0;
>> +
>> +       memcpy(&aya->resp, data, sizeof(aya->resp));
>> +       WRITE_ONCE(aya->resp_pending, false);
>> +       complete(&aya->resp_done);
>> +       return 0;
>> +}
>> +
>> +static ssize_t ayaneo_module_show(struct device *dev, char *buf, bool =
right)
>> +{
>> +       struct ayaneo *aya =3D dev_get_drvdata(dev);
>> +       struct aya3_resp resp;
>> +       int ret =3D 0;
>> +
>> +       scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock)
>> +               ret =3D ayaneo_check(aya, &resp);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return sysfs_emit(buf, "0x%02x\n",
>> +                         right ? resp=2Emodule_right : resp=2Emodule_l=
eft);
>> +}
>> +
>> +static ssize_t module_left_show(struct device *dev,
>> +                               struct device_attribute *attr, char *bu=
f)
>> +{
>> +       return ayaneo_module_show(dev, buf, false);
>> +}
>> +static DEVICE_ATTR_RO(module_left);
>> +
>> +static ssize_t module_right_show(struct device *dev,
>> +                                struct device_attribute *attr, char *b=
uf)
>> +{
>> +       return ayaneo_module_show(dev, buf, true);
>> +}
>> +static DEVICE_ATTR_RO(module_right);
>> +
>> +static ssize_t eject_store(struct device *dev, struct device_attribute=
 *attr,
>> +                          const char *buf, size_t count)
>> +{
>> +       struct ayaneo *aya =3D dev_get_drvdata(dev);
>> +       struct aya3_resp resp;
>> +       u8 eject;
>> +       int ret =3D 0, err, i;
>> +
>> +       if (sysfs_streq(buf, "left"))
>> +               eject =3D AYA3_EJECT_LEFT;
>> +       else if (sysfs_streq(buf, "right"))
>> +               eject =3D AYA3_EJECT_RIGHT;
>> +       else if (sysfs_streq(buf, "both"))
>> +               eject =3D AYA3_EJECT_LEFT | AYA3_EJECT_RIGHT;
>> +       else
>> +               return -EINVAL;
>> +
>> +       scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
>> +               ret =3D ayaneo_send_config(aya, eject);
>> +               if (ret)
>> +                       break;
>> +
>> +               /*
>> +                * Wait for the firmware to report the eject as done=2E
>> +                * Userspace must then cut power through ayaneo-ec's
>> +                * controller_power for the module to be physically
>> +                * released=2E
>> +                */
>> +               ret =3D -ETIMEDOUT;
>> +               for (i =3D 0; i < AYA3_EJECT_POLLS; i++) {
>> +                       msleep(AYA3_EJECT_POLL_MS);
>> +                       err =3D ayaneo_check(aya, &resp);
>> +                       if (err =3D=3D -ETIMEDOUT)
>> +                               continue;       /* busy mid-eject, keep=
 polling */
>> +                       if (err) {
>> +                               ret =3D err;
>> +                               break;
>> +                       }
>> +                       if (!(resp=2Eeject_status & ~AYA3_EJECT_DONE_MA=
SK)) {
>> +                               ret =3D 0;
>> +                               break;
>> +                       }
>> +               }
>> +       }
>> +       return ret ? ret : count;
>> +}
>> +static DEVICE_ATTR_WO(eject);
>> +
>> +static ssize_t reset_store(struct device *dev, struct device_attribute=
 *attr,
>> +                          const char *buf, size_t count)
>> +{
>> +       struct ayaneo *aya =3D dev_get_drvdata(dev);
>> +       bool value;
>> +       int ret;
>> +
>> +       ret =3D kstrtobool(buf, &value);
>> +       if (ret)
>> +               return ret;
>> +       if (!value)
>> +               return count;
>> +
>> +       scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
>> +               ret =3D ayaneo_send_config(aya, AYA3_RESET);
>> +               if (!ret) {
>> +                       msleep(AYA3_RESET_SETTLE_MS);
>> +                       ret =3D ayaneo_send_config(aya, 0);
>> +               }
>> +       }
>> +       return ret ? ret : count;
>> +}
>> +static DEVICE_ATTR_WO(reset);
>> +
>> +static struct attribute *ayaneo_attrs[] =3D {
>> +       &dev_attr_module_left=2Eattr,
>> +       &dev_attr_module_right=2Eattr,
>> +       &dev_attr_eject=2Eattr,
>> +       &dev_attr_reset=2Eattr,
>> +       NULL
>> +};
>> +ATTRIBUTE_GROUPS(ayaneo);
>> +
>> +static int ayaneo_led_set(struct led_classdev *cdev, enum led_brightne=
ss value)
>> +{
>> +       struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
>> +       struct ayaneo *aya =3D container_of(mc, struct ayaneo, mcled);
>> +       int ret =3D 0, i;
>> +
>> +       scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
>> +               led_mc_calc_color_components(mc, value);
>> +               for (i =3D 0; i < 3; i++)
>> +                       aya->rgb[i] =3D min_t(unsigned int,
>> +                                           aya->subleds[i]=2Ebrightnes=
s, 255);
>> +
>> +               ret =3D ayaneo_send_config(aya, 0);
>> +               if (ret)
>> +                       hid_err(aya->hdev,
>> +                               "failed to update RGB config: %d\n", re=
t);
>> +       }
>> +       return ret;
>> +}
>> +
>> +/*
>> + * The firmware offers one fixed breathing pattern, pulsing the curren=
t
>> + * colour at a period it controls=2E Expose it through the hw_pattern
>> + * trigger ABI as the two-step pattern "0 <t> <brightness> <t>"; the
>> + * delta_t values and the repeat count are accepted but not tunable
>> + * (the firmware always repeats indefinitely)=2E
>> + */
>
>Prefer removing semicolons; they have a particular smell ;)
>
>> +static int ayaneo_pattern_set(struct led_classdev *cdev,
>> +                             struct led_pattern *pattern, u32 len, int=
 repeat)
>> +{
>> +       struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
>> +       struct ayaneo *aya =3D container_of(mc, struct ayaneo, mcled);
>> +       int ret =3D 0;
>> +
>> +       if (len !=3D 2 || pattern[0]=2Ebrightness || !pattern[1]=2Ebrig=
htness)
>> +               return -EINVAL;
>> +
>> +       scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
>> +               aya->pulse =3D true;
>> +               ret =3D ayaneo_send_config(aya, 0);
>> +       }
>> +       return ret;
>> +}
>> +
>> +static int ayaneo_pattern_clear(struct led_classdev *cdev)
>> +{
>> +       struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
>> +       struct ayaneo *aya =3D container_of(mc, struct ayaneo, mcled);
>> +       int ret =3D 0;
>> +
>> +       scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
>> +               aya->pulse =3D false;
>> +               ret =3D ayaneo_send_config(aya, 0);
>> +       }
>> +       return ret;
>> +}
>> +
>> +static int ayaneo_register_led(struct ayaneo *aya)
>> +{
>> +       struct led_classdev *cdev =3D &aya->mcled=2Eled_cdev;
>> +
>> +       aya->subleds[0]=2Ecolor_index =3D LED_COLOR_ID_RED;
>> +       aya->subleds[1]=2Ecolor_index =3D LED_COLOR_ID_GREEN;
>> +       aya->subleds[2]=2Ecolor_index =3D LED_COLOR_ID_BLUE;
>> +       aya->mcled=2Esubled_info =3D aya->subleds;
>> +       aya->mcled=2Enum_colors =3D 3;
>> +
>> +       cdev->name =3D devm_kasprintf(&aya->hdev->dev, GFP_KERNEL,
>> +                                   "%s:rgb:joystick_rings",
>> +                                   dev_name(&aya->hdev->dev));
>> +       if (!cdev->name)
>> +               return -ENOMEM;
>> +       cdev->color =3D LED_COLOR_ID_RGB;
>> +       cdev->brightness =3D 0;
>> +       cdev->max_brightness =3D 255;
>> +       cdev->brightness_set_blocking =3D ayaneo_led_set;
>> +       cdev->pattern_set =3D ayaneo_pattern_set;
>> +       cdev->pattern_clear =3D ayaneo_pattern_clear;
>> +
>> +       /*
>> +        * Not devm: the LED must be unregistered before hid_hw_stop() =
in
>> +        * remove, or a concurrent brightness write could reach a torn
>> +        * down transport=2E
>> +        */
>> +       return led_classdev_multicolor_register(&aya->hdev->dev,
>> +                                               &aya->mcled);
>> +}
>> +
>> +static const struct dmi_system_id ayaneo_dmi_table[] =3D {
>> +       {
>> +               =2Ematches =3D {
>> +                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
>> +                       DMI_MATCH(DMI_BOARD_NAME, "AYANEO 3"),
>> +               },
>> +       },
>> +       {}
>> +};
>> +
>> +static int ayaneo_probe(struct hid_device *hdev, const struct hid_devi=
ce_id *id)
>> +{
>> +       struct ayaneo *aya;
>> +       int ret;
>> +
>> +       /* The VID/PID is a generic SigmaMicro ID; bind on AYANEO 3 onl=
y */
>> +       if (!dmi_check_system(ayaneo_dmi_table))
>> +               return -ENODEV;
>> +
>> +       if (!hid_is_usb(hdev))
>> +               return -ENODEV;
>> +
>> +       ret =3D hid_parse(hdev);
>> +       if (ret)
>> +               return ret;
>> +
>> +       /* Bind only the vendor interface, not the gamepad/keyboard one=
s */
>> +       if (!hdev->maxcollection ||
>> +           hdev->collection->usage !=3D (HID_UP_MSVENDOR | 0x0001))
>> +               return -ENODEV;
>> +
>> +       aya =3D devm_kzalloc(&hdev->dev, sizeof(*aya), GFP_KERNEL);
>> +       if (!aya)
>> +               return -ENOMEM;
>> +
>> +       aya->xfer =3D devm_kzalloc(&hdev->dev, AYA3_REPORT_SIZE, GFP_KE=
RNEL);
>> +       if (!aya->xfer)
>> +               return -ENOMEM;
>> +
>> +       aya->hdev =3D hdev;
>> +       aya->vibration =3D AYA3_VIBRATION_MEDIUM;
>> +       init_completion(&aya->resp_done);
>> +       ret =3D devm_mutex_init(&hdev->dev, &aya->lock);
>> +       if (ret)
>> +               return ret;
>> +       hid_set_drvdata(hdev, aya);
>> +
>> +       ret =3D hid_hw_start(hdev, HID_CONNECT_HIDRAW);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret =3D hid_hw_open(hdev);
>> +       if (ret)
>> +               goto err_stop;
>> +
>> +       /* Input reports are not delivered during probe by default */
>> +       hid_device_io_start(hdev);
>> +
>> +       scoped_guard(mutex, &aya->lock)
>> +               ret =3D ayaneo_check(aya, NULL);
>> +       if (ret)
>> +               hid_warn(hdev, "controller did not answer status check:=
 %d\n",
>> +                        ret);
>
>Consider dropping the hid_device =2E=2E=2E check block unless it is
>necessary=2E it seems like a premature test that can go wrong and you
>touch the device=2E Particularly, hid_device_io_start is a bit
>unconventional=2E
>
>With this check removed, this driver does not touch the device without
>userspace involvement, which is good for userspace implementations
>such as mine=2E
>
>I think these are all the comments I have=2E I'd suggest waiting a week
>before the next revision and up to two weeks for jiri/Benjamin to
>reply with some comments as I think I was the only one that reviewed
>the previous revision=2E
>
>Best,
>Antheas
>
>> +
>> +       ret =3D ayaneo_register_led(aya);
>> +       if (ret)
>> +               goto err_close;
>> +
>> +       return 0;
>> +
>> +err_close:
>> +       hid_hw_close(hdev);
>> +err_stop:
>> +       hid_hw_stop(hdev);
>> +       return ret;
>> +}
>> +
>> +static void ayaneo_remove(struct hid_device *hdev)
>> +{
>> +       struct ayaneo *aya =3D hid_get_drvdata(hdev);
>> +
>> +       led_classdev_multicolor_unregister(&aya->mcled);
>> +       /*
>> +        * A brightness store racing with the unregister can requeue
>> +        * set_brightness_work after the flush inside
>> +        * led_classdev_unregister() runs but before the sysfs node is
>> +        * removed=2E Flush again now that nothing can requeue it, whil=
e
>> +        * the transport is still up=2E
>> +        */
>> +       flush_work(&aya->mcled=2Eled_cdev=2Eset_brightness_work);
>> +       hid_hw_close(hdev);
>> +       hid_hw_stop(hdev);
>> +}
>> +
>> +static const struct hid_device_id ayaneo_devices[] =3D {
>> +       { HID_USB_DEVICE(0x1c4f, 0x0002) },
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(hid, ayaneo_devices);
>> +
>> +static struct hid_driver ayaneo_driver =3D {
>> +       =2Ename =3D "hid-ayaneo",
>> +       =2Eid_table =3D ayaneo_devices,
>> +       =2Eprobe =3D ayaneo_probe,
>> +       =2Eremove =3D ayaneo_remove,
>> +       =2Eraw_event =3D ayaneo_raw_event,
>> +       =2Edriver =3D {
>> +               =2Edev_groups =3D ayaneo_groups,
>> +       },
>> +};
>> +module_hid_driver(ayaneo_driver);
>> +
>> +MODULE_AUTHOR("Mat=C3=ADas Mart=C3=ADnez <hello@matias=2Eme>");
>> +MODULE_DESCRIPTION("AYANEO 3 detachable controller driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2=2E54=2E0 (Apple Git-157)
>>
>>
>

