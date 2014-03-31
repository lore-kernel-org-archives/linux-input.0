From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: multitouch: add support for Win 8.1 multitouch touchpads
Date: Mon, 31 Mar 2014 11:19:41 -0400
Message-ID: <CAN+gG=EG2mGfdZhdHcT1L0tsjpxhqHP5NEJuf6L9P+3DJ5yALg@mail.gmail.com>
References: <1395261543-3103-1-git-send-email-aduggan@synaptics.com>
	<alpine.LNX.2.00.1403201002260.3690@pobox.suse.cz>
	<CAN+gG=HtEpKi-bjf-Aq7+Ko8MFnyXyfgL72D3pYo0NE9ZdWBsA@mail.gmail.com>
	<CA+BWVURMCnkt8NtRorj+mifHWEGs=0TZbFAqmusKoXyVQj-QZA@mail.gmail.com>
	<CA+BWVUQxyM2CkXiQLJi+yrjCEGiFWMur9UQvxV8K1PYTRPpCmQ@mail.gmail.com>
	<CAN+gG=EFTD6aTne9dPNhn=SwjE6fjc1GW_ROiEc0_PyLz20LLQ@mail.gmail.com>
	<CA+BWVUQG82TQZQNk4GTY6NVY3Fsm94LJ==JwpXrr3EBhnCzfSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:37389 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbaCaPTn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Mar 2014 11:19:43 -0400
Received: by mail-lb0-f178.google.com with SMTP id s7so6021044lbd.9
        for <linux-input@vger.kernel.org>; Mon, 31 Mar 2014 08:19:41 -0700 (PDT)
In-Reply-To: <CA+BWVUQG82TQZQNk4GTY6NVY3Fsm94LJ==JwpXrr3EBhnCzfSA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Reyad Attiyat <reyad.attiyat@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

Hi Reyad,

thanks for the logs.

So, several things here:
- the report descriptor is indeed messed, so we will have to fix it
- once it will be fixed, we can use hid-mt to deal with the touch cover
- however, either you truncated the events, or the device is pure
crap. I got touches stuck with the values you submitted, and I have no
way to retrieve the releases.
- hid_scan_report needs to be fixed to prevent this failures in the future.

I am going to submit a revert of the hid-microsoft commit and a fix
for the hid_scan_report().

Depending on whether you truncated the events, we will think at
patching the report descriptor to make it actually working.

Cheers,
Benjamin


On Sun, Mar 30, 2014 at 1:29 AM, Reyad Attiyat <reyad.attiyat@gmail.com> wrote:
> Hey,
>
> I have reverted the old patch 117309.. and forced the class
> MT_CLS_EXPORT_ALL_INPUTS on this device. The keyboard and mouse work
> in this setup.
> When input mode is set to 2 (MT_INPUTMODE_TOUCHSCREEN) hid-recorder outputs:
>
> R: 472 05 01 09 06 a1 01 85 01 15 00 25 01 75 01 95 08 05 07 19 e0 29
> e7 81 02 75 08 95 0a 19 00 29 91 26 ff 00 81 00 05 0c 0a c0 02 a1 02
> 1a c1 02 2a c6 02 95 06 b1 03 c0 05 08 19 01 29 03 75 01 95 03 25 01
> 91 02 95 05 91 03 c0 05 01 09 02 a1 01 85 02 05 09 19 01 29 05 81 02
> 95 01 75 03 81 03 15 81 25 7f 75 08 95 02 05 01 09 30 09 31 81 06 a1
> 02 09 48 15 00 25 01 35 01 45 10 75 02 95 01 a4 b1 02 09 38 15 81 25
> 7f 35 00 45 00 75 08 81 06 c0 a1 02 09 48 b4 b1 02 35 00 45 00 75 04
> b1 03 05 0c 0a 38 02 15 81 25 7f 75 08 81 06 c0 c0 05 0c 09 01 a1 01
> 85 03 75 10 15 00 26 ff 03 19 00 2a ff 03 81 00 c0 06 05 ff 09 01 a1
> 01 85 09 25 ff 95 02 75 08 09 20 81 02 09 22 91 02 15 81 25 7f 95 20
> 75 08 09 21 81 02 09 23 91 02 c0 09 02 a1 01 85 0f 15 00 25 ff 95 01
> 09 00 91 02 c0 05 0d 09 05 a1 01 85 04 09 22 a1 02 15 00 25 01 09 47
> 09 42 95 02 75 01 81 03 95 01 75 02 25 02 09 51 81 03 75 01 95 04 81
> 03 05 01 35 00 65 11 55 0d 75 10 95 01 09 30 26 ff 03 46 5e 1a 81 03
> 09 31 26 ff 01 46 80 0c 81 03 c0 05 0d 09 56 55 0c 66 01 10 47 ff ff
> 00 00 27 ff ff 00 00 81 03 09 54 25 7f 75 08 81 03 05 09 09 01 25 01
> 75 01 81 03 95 07 81 03 05 0d 85 04 09 55 09 59 75 04 95 02 25 0f b1
> 03 06 00 ff 09 c6 85 05 15 00 25 08 75 08 95 01 b1 02 09 c7 26 ff 00
> 75 08 95 20 b1 02 c0 05 0d 09 0e a1 01 85 06 09 22 a1 02 09 52 09 52
> 15 00 25 0a 75 08 95 01 b1 02 c0 85 0b 09 22 a1 00 09 57 09 58 15 00
> 25 01 75 01 95 02 b1 02 95 06 b1 03 c0 c0
> N: MICROSOFT SAM
> P: usb-0000:00:14.0-3/input2
> I: 3 045e 07a9
> E: 0.000001 12 01 00 00 00 00 00 00 00 00 00 00 00
> E: 1.044575 6 02 00 f7 00 00 00
> E: 1.052450 6 02 00 f7 00 00 00
> E: 1.056451 6 02 00 fd 00 00 00
> E: 1.064307 6 02 00 f3 00 00 00
> E: 1.072314 6 02 00 f3 ff 00 00
> E: 1.080422 6 02 00 f2 ff 00 00
> E: 1.088323 6 02 00 f6 00 00 00
> E: 1.096446 6 02 00 f1 00 00 00
> E: 1.104276 6 02 00 f2 01 00 00
> E: 1.112225 6 02 00 f3 00 00 00
> E: 1.120162 6 02 00 f5 00 00 00
> E: 1.128130 6 02 00 f8 01 00 00
> E: 1.136120 6 02 00 f9 00 00 00
> E: 1.144190 6 02 00 fe 00 00 00
> E: 1.148212 6 02 00 fb 01 00 00
> E: 1.156311 6 02 00 fc 01 00 00
> E: 1.164293 6 02 00 fd 00 00 00
> E: 1.172407 6 02 00 fe 00 00 00
> E: 1.184526 6 02 00 fe 01 00 00
> E: 1.192372 6 02 00 ff 00 00 00
>
>
> When input is set to 3 hid-recorder output is:
>
> R: 472 05 01 09 06 a1 01 85 01 15 00 25 01 75 01 95 08 05 07 19 e0 29
> e7 81 02 75 08 95 0a 19 00 29 91 26 ff 00 81 00 05 0c 0a c0 02 a1 02
> 1a c1 02 2a c6 02 95 06 b1 03 c0 05 08 19 01 29 03 75 01 95 03 25 01
> 91 02 95 05 91 03 c0 05 01 09 02 a1 01 85 02 05 09 19 01 29 05 81 02
> 95 01 75 03 81 03 15 81 25 7f 75 08 95 02 05 01 09 30 09 31 81 06 a1
> 02 09 48 15 00 25 01 35 01 45 10 75 02 95 01 a4 b1 02 09 38 15 81 25
> 7f 35 00 45 00 75 08 81 06 c0 a1 02 09 48 b4 b1 02 35 00 45 00 75 04
> b1 03 05 0c 0a 38 02 15 81 25 7f 75 08 81 06 c0 c0 05 0c 09 01 a1 01
> 85 03 75 10 15 00 26 ff 03 19 00 2a ff 03 81 00 c0 06 05 ff 09 01 a1
> 01 85 09 25 ff 95 02 75 08 09 20 81 02 09 22 91 02 15 81 25 7f 95 20
> 75 08 09 21 81 02 09 23 91 02 c0 09 02 a1 01 85 0f 15 00 25 ff 95 01
> 09 00 91 02 c0 05 0d 09 05 a1 01 85 04 09 22 a1 02 15 00 25 01 09 47
> 09 42 95 02 75 01 81 03 95 01 75 02 25 02 09 51 81 03 75 01 95 04 81
> 03 05 01 35 00 65 11 55 0d 75 10 95 01 09 30 26 ff 03 46 5e 1a 81 03
> 09 31 26 ff 01 46 80 0c 81 03 c0 05 0d 09 56 55 0c 66 01 10 47 ff ff
> 00 00 27 ff ff 00 00 81 03 09 54 25 7f 75 08 81 03 05 09 09 01 25 01
> 75 01 81 03 95 07 81 03 05 0d 85 04 09 55 09 59 75 04 95 02 25 0f b1
> 03 06 00 ff 09 c6 85 05 15 00 25 08 75 08 95 01 b1 02 09 c7 26 ff 00
> 75 08 95 20 b1 02 c0 05 0d 09 0e a1 01 85 06 09 22 a1 02 09 52 09 52
> 15 00 25 0a 75 08 95 01 b1 02 c0 85 0b 09 22 a1 00 09 57 09 58 15 00
> 25 01 75 01 95 02 b1 02 95 06 b1 03 c0 c0
> N: MICROSOFT SAM
> P: usb-0000:00:14.0-3/input2
> I: 3 045e 07a9
>
> One Finger - side to side swipes
>
> E: 0.000000 10 04 03 1f 02 ed 00 c4 e2 01 00
> E: 0.020089 10 04 03 1f 02 ed 00 0a e3 01 00
> E: 0.023972 10 04 03 1f 02 ed 00 50 e3 01 00
> E: 0.027967 10 04 03 1f 02 ed 00 96 e3 01 00
> E: 0.031878 10 04 03 1f 02 ed 00 dc e3 01 00
> E: 0.035809 10 04 03 14 02 eb 00 f0 e3 01 00
> E: 0.039936 10 04 03 10 02 eb 00 36 e4 01 00
> E: 0.043969 10 04 03 0f 02 ea 00 40 e4 01 00
> E: 0.047682 10 04 03 04 02 e9 00 86 e4 01 00
> E: 0.055592 10 04 03 fb 01 e8 00 cc e4 01 00
> E: 0.059593 10 04 03 f9 01 e7 00 d6 e4 01 00
> E: 0.063589 10 04 03 f1 01 e5 00 1c e5 01 00
> E: 0.067561 10 04 03 ee 01 e4 00 30 e5 01 00
> E: 0.071724 10 04 03 eb 01 e4 00 6c e5 01 00
> E: 0.075660 10 04 03 e0 01 e3 00 a8 e5 01 00
> E: 0.079566 10 04 03 d2 01 e1 00 ee e5 01 00
> E: 0.091504 10 04 03 c7 01 df 00 34 e6 01 00
> E: 0.095476 10 04 03 c5 01 de 00 3e e6 01 00
> E: 0.099484 10 04 03 ba 01 dc 00 84 e6 01 00
> E: 0.107550 10 04 03 ac 01 db 00 ca e6 01 00
> E: 0.111504 10 04 03 aa 01 da 00 d4 e6 01 00
> E: 0.115485 10 04 03 9f 01 d9 00 1a e7 01 00
> E: 0.119496 10 04 03 9d 01 d8 00 24 e7 01 00
> E: 0.123471 10 04 03 8f 01 d7 00 6a e7 01 00
> E: 0.127468 10 04 03 8d 01 d6 00 74 e7 01 00
> E: 0.131469 10 04 03 7f 01 d5 00 ba e7 01 00
> E: 0.135467 10 04 03 76 01 d4 00 e2 e7 01 00
> E: 0.143466 10 04 03 62 01 d3 00 28 e8 01 00
> E: 0.147468 10 04 03 5f 01 d2 00 32 e8 01 00
> E: 0.151467 10 04 03 51 01 d2 00 78 e8 01 00
> E: 0.155467 10 04 03 4f 01 d1 00 82 e8 01 00
> E: 0.159467 10 04 03 48 01 d1 00 c8 e8 01 00
> E: 0.163467 10 04 03 36 01 d0 00 04 e9 01 00
> E: 0.167467 10 04 03 28 01 cf 00 4a e9 01 00
> E: 0.179468 10 04 03 1e 01 cf 00 90 e9 01 00
> E: 0.183466 10 04 03 1c 01 cf 00 9a e9 01 00
> E: 0.187468 10 04 03 14 01 ce 00 e0 e9 01 00
> E: 0.191467 10 04 03 0c 01 ce 00 26 ea 01 00
> E: 0.195467 10 04 03 0a 01 cf 00 30 ea 01 00
> E: 0.199467 10 04 03 04 01 cf 00 76 ea 01 00
> E: 0.203467 10 04 03 02 01 cf 00 8a ea 01 00
> E: 0.211466 10 04 03 fd 00 cf 00 d0 ea 01 00
> E: 0.215467 10 04 03 fc 00 cf 00 da ea 01 00
> E: 0.219467 10 04 03 f8 00 cf 00 20 eb 01 00
> E: 0.223470 10 04 03 f6 00 ce 00 3e eb 01 00
> E: 0.227468 10 04 03 f1 00 ce 00 84 eb 01 00
> E: 0.231467 10 04 03 f0 00 ce 00 8e eb 01 00
> E: 0.235467 10 04 03 ed 00 ce 00 d4 eb 01 00
> E: 0.239466 10 04 03 ec 00 ce 00 de eb 01 00
> E: 0.243467 10 04 03 ea 00 ce 00 24 ec 01 00
> E: 0.251464 10 04 03 e9 00 ce 00 6a ec 01 00
> E: 0.255466 10 04 03 e8 00 ce 00 74 ec 01 00
> E: 0.259467 10 04 03 e6 00 ce 00 ba ec 01 00
> E: 0.263467 10 04 03 e5 00 ce 00 c4 ec 01 00
> E: 0.267467 10 04 03 e5 00 ce 00 0a ed 01 00
> E: 0.271479 10 04 03 e4 00 ce 00 3c ed 01 00
> E: 1.167556 10 04 01 79 01 b6 00 64 10 01 00
>
> Two Fingers
>
> E: 3.404049 10 04 03 85 03 fc 00 e4 67 01 00
> E: 3.428076 10 04 03 85 03 fc 00 2a 68 01 00
> E: 3.431899 10 04 03 85 03 fc 00 70 68 01 00
> E: 3.435812 10 04 03 85 03 fc 00 a2 68 02 00
> E: 3.439773 10 04 07 98 01 af 00 a2 68 00 00
> E: 3.447819 10 04 03 85 03 fc 00 f2 68 02 00
> E: 3.451729 10 04 07 99 01 b0 00 f2 68 00 00
> E: 3.455721 10 04 03 85 03 fc 00 42 69 02 00
> E: 3.459697 10 04 07 99 01 b0 00 42 69 00 00
> E: 3.463677 10 04 03 85 03 fc 00 92 69 02 00
> E: 3.467672 10 04 07 99 01 b0 00 92 69 00 00
> E: 3.471641 10 04 03 85 03 fc 00 e2 69 02 00
> E: 3.475641 10 04 07 99 01 b0 00 e2 69 00 00
> E: 3.479649 10 04 03 85 03 fc 00 32 6a 02 00
> E: 3.483616 10 04 07 99 01 b0 00 32 6a 00 00
> E: 3.487614 10 04 03 85 03 fc 00 82 6a 02 00
> E: 3.491461 10 04 07 99 01 b0 00 82 6a 00 00
> E: 3.495460 10 04 03 85 03 fc 00 d2 6a 02 00
> E: 3.499461 10 04 07 99 01 b0 00 d2 6a 00 00
> E: 3.503460 10 04 03 85 03 fc 00 22 6b 02 00
> E: 3.507461 10 04 07 99 01 b0 00 22 6b 00 00
> E: 3.511458 10 04 03 85 03 fc 00 72 6b 02 00
> E: 3.515460 10 04 07 99 01 b0 00 72 6b 00 00
> E: 3.519460 10 04 03 85 03 fc 00 c2 6b 02 00
> E: 3.523460 10 04 07 99 01 b0 00 c2 6b 00 00
> E: 3.527460 10 04 03 85 03 fc 00 12 6c 02 00
> E: 3.531466 10 04 07 99 01 b0 00 12 6c 00 00
> E: 3.535459 10 04 03 85 03 fc 00 62 6c 02 00
> E: 3.539460 10 04 07 99 01 b0 00 62 6c 00 00
> E: 3.543460 10 04 03 85 03 fc 00 b2 6c 02 00
> E: 3.547461 10 04 07 99 01 b0 00 b2 6c 00 00
> E: 3.551460 10 04 03 85 03 fc 00 02 6d 02 00
> E: 3.555460 10 04 07 99 01 b0 00 02 6d 00 00
> E: 3.559460 10 04 03 85 03 fc 00 52 6d 02 00
> E: 3.563460 10 04 07 99 01 b0 00 52 6d 00 00
> E: 3.567459 10 04 03 85 03 fc 00 a2 6d 02 00
> E: 3.571460 10 04 07 99 01 b0 00 a2 6d 00 00
> E: 3.575460 10 04 03 85 03 fc 00 f2 6d 02 00
> E: 3.579460 10 04 07 99 01 b0 00 f2 6d 00 00
> E: 3.583460 10 04 03 85 03 fc 00 42 6e 02 00
> E: 3.587460 10 04 07 99 01 b0 00 42 6e 00 00
> E: 3.591459 10 04 03 85 03 fc 00 92 6e 02 00
> E: 3.595460 10 04 07 99 01 b0 00 92 6e 00 00
> E: 3.599459 10 04 03 85 03 fc 00 e2 6e 02 00
> E: 3.603460 10 04 07 99 01 b0 00 e2 6e 00 00
> E: 3.607459 10 04 03 85 03 fc 00 32 6f 02 00
> E: 3.611460 10 04 07 99 01 b0 00 32 6f 00 00
> E: 3.615459 10 04 03 85 03 fc 00 82 6f 02 00
> E: 3.619460 10 04 07 8d 01 b2 00 82 6f 00 00
> E: 3.623460 10 04 03 7b 03 02 01 d2 6f 02 00
> E: 3.627476 10 04 07 84 01 b2 00 d2 6f 00 00
> E: 3.631423 10 04 03 6c 03 02 01 22 70 02 00
> E: 3.635495 10 04 07 73 01 b3 00 22 70 00 00
> E: 3.639475 10 04 03 5a 03 01 01 68 70 02 00
> E: 3.643479 10 04 07 67 01 b4 00 68 70 00 00
> E: 3.647369 10 04 03 4d 03 01 01 ae 70 02 00
> E: 3.651602 10 04 07 52 01 b5 00 ae 70 00 00
> E: 3.655649 10 04 03 4c 03 01 01 fe 70 02 00
> E: 3.659657 10 04 07 51 01 b6 00 fe 70 00 00
> E: 3.663650 10 04 03 34 03 01 01 08 71 02 00
> E: 3.667663 10 04 07 43 01 b6 00 08 71 00 00
> E: 3.671650 10 04 03 25 03 02 01 4e 71 02 00
> E: 3.675577 10 04 07 32 01 b7 00 4e 71 00 00
> E: 3.679686 10 04 03 1a 03 02 01 94 71 02 00
> E: 3.684002 10 04 07 29 01 b8 00 94 71 00 00
> E: 3.687960 10 04 03 0b 03 03 01 da 71 02 00
> E: 5.011753 10 04 05 b9 00 ea 00 e8 9a 00 00
>
> Three Fingers - I can't imagine someone using more on this size of touchpad
>
> E: 8.512034 10 04 03 01 01 30 01 44 2f 01 00
> E: 8.531887 10 04 03 01 01 30 01 8a 2f 01 00
> E: 8.535992 10 04 03 01 01 30 01 d0 2f 01 00
> E: 8.539861 10 04 03 01 01 30 01 16 30 01 00
> E: 8.543796 10 04 03 01 01 30 01 5c 30 01 00
> E: 8.547750 10 04 03 01 01 30 01 a2 30 01 00
> E: 8.551763 10 04 03 01 01 30 01 e8 30 01 00
> E: 8.559774 10 04 03 01 01 30 01 2e 31 01 00
> E: 8.563713 10 04 03 01 01 30 01 74 31 01 00
> E: 8.571685 10 04 03 fa 00 2c 01 c4 31 01 00
> E: 8.579631 10 04 03 f9 00 2b 01 14 32 01 00
> E: 8.595606 10 04 03 f9 00 2b 01 5a 32 01 00
> E: 8.599448 10 04 03 f9 00 2b 01 6e 32 02 00
> E: 8.603459 10 04 07 8a 03 36 01 6e 32 00 00
> E: 8.607448 10 04 03 f9 00 2b 01 be 32 02 00
> E: 8.611449 10 04 07 8b 03 37 01 be 32 00 00
> E: 8.615447 10 04 03 f9 00 2b 01 c8 32 03 00
> E: 8.619449 10 04 07 8a 03 36 01 c8 32 00 00
> E: 8.623450 10 04 0b 29 02 ab 00 c8 32 00 00
> E: 8.627449 10 04 03 f8 00 2b 01 0e 33 03 00
> E: 8.631448 10 04 07 8a 03 36 01 0e 33 00 00
> E: 8.635448 10 04 0b 29 02 ab 00 0e 33 00 00
> E: 8.639448 10 04 03 f7 00 2b 01 5e 33 03 00
> E: 8.643448 10 04 07 8a 03 36 01 5e 33 00 00
> E: 8.647448 10 04 0b 29 02 ab 00 5e 33 00 00
> E: 8.651448 10 04 03 f8 00 2a 01 86 33 03 00
> E: 8.655448 10 04 07 8a 03 36 01 86 33 00 00
> E: 8.659448 10 04 0b 29 02 ab 00 86 33 00 00
> E: 8.663447 10 04 03 f7 00 2a 01 cc 33 03 00
> E: 8.667449 10 04 07 8a 03 36 01 cc 33 00 00
> E: 8.671448 10 04 0b 29 02 ab 00 cc 33 00 00
> E: 8.675447 10 04 03 f6 00 2a 01 1c 34 03 00
> E: 8.679448 10 04 07 8a 03 36 01 1c 34 00 00
> E: 8.683448 10 04 0b 29 02 ab 00 1c 34 00 00
> E: 8.687447 10 04 03 f6 00 2a 01 62 34 03 00
> E: 8.691448 10 04 07 8a 03 36 01 62 34 00 00
> E: 8.695469 10 04 0b 29 02 ab 00 62 34 00 00
> E: 8.699449 10 04 03 f6 00 2a 01 b2 34 03 00
> E: 8.703447 10 04 07 8a 03 36 01 b2 34 00 00
> E: 8.707446 10 04 0b 29 02 ab 00 b2 34 00 00
> E: 8.711447 10 04 03 f5 00 2a 01 f8 34 03 00
> E: 8.715448 10 04 07 8a 03 36 01 f8 34 00 00
> E: 8.719447 10 04 0b 29 02 ab 00 f8 34 00 00
> E: 8.723448 10 04 03 f5 00 2a 01 48 35 03 00
> E: 8.727446 10 04 07 82 03 36 01 48 35 00 00
> E: 9.867933 10 04 05 36 03 1f 01 86 5b 00 00
>
> Tested keyboard - worked as expected
>
> E: 12.139656 12 01 00 14 00 00 00 00 00 00 00 00 00
> qE: 12.251482 12 01 00 00 00 00 00 00 00 00 00 00 00
> E: 12.579961 12 01 00 1a 00 00 00 00 00 00 00 00 00
> wE: 12.691797 12 01 00 00 00 00 00 00 00 00 00 00 00
> E: 13.027924 12 01 00 08 00 00 00 00 00 00 00 00 00
> eE: 13.159919 12 01 00 00 00 00 00 00 00 00 00 00 00
> E: 13.479970 12 01 00 15 00 00 00 00 00 00 00 00 00
> rE: 13.579955 12 01 00 00 00 00 00 00 00 00 00 00 00
> E: 14.007968 12 01 00 17 00 00 00 00 00 00 00 00 00
> tE: 14.107946 12 01 00 00 00 00 00 00 00 00 00 00 00
> E: 14.471932 12 01 00 1c 00 00 00 00 00 00 00 00 00
> yE: 14.571838 12 01 00 00 00 00 00 00 00 00 00 00 00
>
> Hope this is everything you needed. If there is any other test you
> need performed just let me know. One more thing I should note is that
> I did not see a cursor when input mode is set to three.
>
> On Sat, Mar 29, 2014 at 11:07 PM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
>> Hi Reyad,
>>
>> Thanks for the tests. I was surprised to hear that this patch did not
>> work for you. I made some tests too and the touchpad collection does
>> not appear right now.
>> This was until I realized that the report descriptor I have regarding
>> the Surface 2 was completely buggy.
>> So it seems that either I have a bad one, or the one actually inside
>> the device is buggy (which would explain why you don't get any
>> output).
>>
>> The report descriptor declares all the events regarding the touchpad
>> as constant, and the hid subsystem ignores them :)
>>
>> To be able to provide a good solution, I would like you to conduct
>> some more tests:
>>
>> - revert commit 117309c51dca42121f70cacec801511b76acf75c (yours
>> actually :-P ) to handle the touch cover through hid-multitouch (you
>> should have done it already I think).
>> - register the touchcover surface 2 as using the class
>> MT_CLS_EXPORT_ALL_INPUTS (optional step, but you should be able to
>> have a keyboard with this)
>> - change mt_set_input_mode() in hid-multitouch.c to actually use "3"
>> as the td->inputmode_value (just overwite the value before putting it
>> in the field)
>> - please download and install hid-replay [1]
>>
>> run hid-recorder with (and without to check) the 3 as input mode, you
>> should receive events starting with "E: xxxxx..xxx XX 04 ....." when
>> playing with the touchpad.
>> (without the 3 as inputmode_value, you should receive  "E: xxxxx..xxx
>> XX 02 .....")
>>
>> Then, send me the recording from hid-recorder of a few keyboard
>> touches + touchpad events (single touch, dual touch, and more fingers)
>> so I can test and explain you how to fix the report descriptor in the
>> kernel.
>>
>>
>> Cheers,
>> Benjamin
>>
>>
>> On Sat, Mar 29, 2014 at 9:23 PM, Reyad Attiyat <reyad.attiyat@gmail.com> wrote:
>>> Hey Benjamin,
>>>
>>> I was the one to submit the original Surface 2 patch. I have been
>>> testing the 3.15/multitouch branch with the Surface Pro 2 type cover.
>>> This patch doesn't actual enable the keyboard/mouse to work. This
>>> patch only works when there is a HID_UP_BUTTON and/or HID_DG_TOUCHPAD
>>> in usage, which is not the case on this device. The reason the type
>>> cover is not working with hid-multitouch is mt_input_mapping is
>>> returing -1 to ignore the device. This happens becuase of:
>>>
>>> if (!td->mtclass.export_all_inputs &&
>>>    field->application != HID_DG_TOUCHSCREEN &&
>>>    field->application != HID_DG_PEN &&
>>>    field->application != HID_DG_TOUCHPAD)
>>> return -1;
>>>
>>>
>>> I notice that there is now a mt.export_all_inputs which could allow
>>> the surface type cover keyboard to get handled properly. Is this
>>> something that sould be added to hid-multitouch for this device? The
>>> driver could check for device ID's and set export_all_inputs to true.
>>> It could also check for GenericDesktop application in hid field and
>>> return 0 in mt_input_mapping.
>>>
>>> I can submit a patch with one of these changes if you think it would
>>> be better than the current patch for the surface from Derya. I belive
>>> that patch adds hardware ID's to hid core and sets the HID Group to
>>> generic.
>>>
>>> On Thu, Mar 20, 2014 at 12:36 PM, Benjamin Tissoires
>>> <benjamin.tissoires@gmail.com> wrote:
>>>> On Thu, Mar 20, 2014 at 5:02 AM, Jiri Kosina <jkosina@suse.cz> wrote:
>>>>> On Wed, 19 Mar 2014, Andrew Duggan wrote:
>>>>>
>>>>>> Multitouch touchpads built for Win 8.1 need to be sent an input mode feature report
>>>>>> in order to start reporting multitouch events. This is the same process sent
>>>>>> to Win 7 multitouch touchscreens except the value of the feature report is 3 for
>>>>>> touchpads.
>>>>>>
>>>>>> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
>>>>>> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>>>>
>>>>> Applied, thanks.
>>>>
>>>> Thanks Jiri.
>>>>
>>>> Derya, can you test if this also solves the problem with the Surface 2
>>>> touch cover?
>>>> (if you remove the special vendor handling in hid_scan_report)
>>>>
>>>> Cheers,
>>>> Benjamin
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
