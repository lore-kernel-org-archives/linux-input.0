Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C932C43381
	for <linux-input@archiver.kernel.org>; Sat,  6 Feb 2021 04:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7062664E34
	for <linux-input@archiver.kernel.org>; Sat,  6 Feb 2021 04:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhBFEHV (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 5 Feb 2021 23:07:21 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:33542 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbhBFEEc (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 5 Feb 2021 23:04:32 -0500
Date:   Sat, 06 Feb 2021 04:03:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1612584222;
        bh=rH9+1TMX2RC9cj0cYXZ7jbg4WmLcpNesr1gFVZytxAw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=Sr/JBUkmc8LN6CXtBtQGeGIBJGEHb5qRdeDEOAmBqzVvstkUX5QGd873ieV84Xe1I
         Jkwo2+gGoQDHJGZePK5q43NIeLC3ejx9l696GKT+vN2NmilHBW4nRMxJHhdVnby7Hv
         4mABRJREV8EfQf+w+qKqASSjnq4LOaHqwJtrwFbA=
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Roderick Colenbrander <roderick@gaikai.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Chris Ye <lzye@google.com>,
        =?utf-8?Q?Samuel_=C4=8Cavoj?= <sammko@sammserver.com>,
        =?utf-8?Q?Florian_M=C3=A4rkl?= <linux@florianmaerkl.de>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v5 00/13] HID: new driver for PS5 'DualSense' controller
Message-ID: <BSS2VIzUg6n3H_LHkC8vJVbSUi11kOgWTAPdurpx1i13T2qL1vJZg_rZIoX5ChX17cu3xu5k33VcKG52xWWTlDfFjyM_YcsTgitebXIsB8I=@protonmail.com>
In-Reply-To: <CAO-hwJLi+twcmSFkbPHHJ23CpF5P=EORsVauyhwvGt9dGoq++A@mail.gmail.com>
References: <20210128172657.24516-1-roderick@gaikai.com> <CAO-hwJLi+twcmSFkbPHHJ23CpF5P=EORsVauyhwvGt9dGoq++A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hi


2021. febru=C3=A1r 5., p=C3=A9ntek 18:01 keltez=C3=A9ssel, Benjamin Tissoir=
es =C3=ADrta:

> Hi,
>
> On Thu, Jan 28, 2021 at 6:27 PM Roderick Colenbrander
> roderick@gaikai.com wrote:
>
> > From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> > Hi,
> > This is hopefully the final revision of this patch series. Patch v4 had
> > a rebase issue of a part of the sensors patch for which a part had move=
d
> > to the end of the series. This has been fixed. I have double, no triple
> > checked the patches. Made sure they build using a 'rebase -x' script
> > and also ran the hid-tools tests on the final driver.
> > Thanks to everyone who provided feedback through the mailing list or pr=
ivately.
> > As suggested by Benjamin on the 'v4' version of this email, if you were
> > involed in the review or testing of this series and would like some cre=
dit,
> > please provide a reviewed-by or tested-by tag.
> > Changes since v4:
> >
> > -   Fixed bad rebase of ps_sensors_create, moved it to appropriate patc=
h.
>
> Barnab=C3=A1s, any comments on this version?
>
> As soon as I get your rev-by, we can apply the series, just in time for 5=
.12.
>

Sorry for not responding earlier, I have been relatively busy lately. I hav=
e taken
another look at the final source file. I have a couple comments for Roderic=
k:

 - `player_ids` array should be `static const` as far as I can see;
 - there are a couple devm_kasprintf() calls which are not checked;
 - power_supply_powers() call is not checked - I think either a comment
   should mention that it's not considered a fatal error, or checked

There are also other more minor things, formatting inconsistencies, but I
cannot see anything else, so with the aforementioned things fixed, if you w=
ant:

Reviewed-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>


Regards,
Barnab=C3=A1s P=C5=91cze


> Roderick, I do see a few checkpath errors that could be fixed, but I
> won't hole the series against:
> HID: playstation: add DualSense battery support. -> WARNING: Missing a
> blank line after declarations
> HID: playstation: report DualSense hardware and firmware version. ->
> WARNING: Consider renaming function(s) 'ps_show_firmware_version' to
> 'firmware_version_show' (and same for ps_show_hardware_version)
>
> Also, there is a weird sparse error:
> +drivers/hid/hid-playstation.c:xxx:1:.error: static assertion failed:
> "sizeof(struct dualsense_input_report) =3D=3D DS_INPUT_REPORT_USB_SIZE -
> 1"
> +drivers/hid/hid-playstation.c:xxx:1:.error: static assertion failed:
> "sizeof(struct dualsense_output_report_bt) =3D=3D
> DS_OUTPUT_REPORT_BT_SIZE"
>
> It's weird because it only fails while running sparse, when the normal
> compilation is just fine, and the assert is correctly evaluated.
>
> Anyway, the series is good from my Point of View, but I'd like to get
> the reviewers some credits.
>
> Cheers,
> Benjamin
>
> > Thanks,
> > Roderick Colenbrander
> > Sony Interactive Entertainment, LLC
> > Roderick Colenbrander (13):
> > HID: playstation: initial DualSense USB support.
> > HID: playstation: use DualSense MAC address as unique identifier.
> > HID: playstation: add DualSense battery support.
> > HID: playstation: add DualSense touchpad support.
> > HID: playstation: add DualSense accelerometer and gyroscope support.
> > HID: playstation: track devices in list.
> > HID: playstation: add DualSense Bluetooth support.
> > HID: playstation: add DualSense classic rumble support.
> > HID: playstation: add DualSense lightbar support
> > HID: playstation: add microphone mute support for DualSense.
> > HID: playstation: add DualSense player LEDs support.
> > HID: playstation: DualSense set LEDs to default player id.
> > HID: playstation: report DualSense hardware and firmware version.
> > MAINTAINERS | 6 +
> > drivers/hid/Kconfig | 21 +
> > drivers/hid/Makefile | 1 +
> > drivers/hid/hid-ids.h | 1 +
> > drivers/hid/hid-playstation.c | 1492 +++++++++++++++++++++++++++++++++
> > 5 files changed, 1521 insertions(+)
> > create mode 100644 drivers/hid/hid-playstation.c
> > --
> > 2.26.2


