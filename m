From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Subject: Re: [PATCH] elan_i2c: Add ACPI ID "ELAN1000"
Date: Tue, 1 Sep 2015 17:15:55 -0400
Message-ID: <CA+A7VXUXnNghu5ZCJoWo=w1vBpx43hy5AeypxJtxOVfMkhtt5Q@mail.gmail.com>
References: <1441137231-615-1-git-send-email-jprvita@endlessm.com> <CAKdAkRTWs1T7ZnMYABKtw2j3vfpVz5ngLdnehPcFoY4pz_jAoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:35640 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbbIAVQf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Sep 2015 17:16:35 -0400
Received: by ykax124 with SMTP id x124so3817644yka.2
        for <linux-input@vger.kernel.org>; Tue, 01 Sep 2015 14:16:35 -0700 (PDT)
In-Reply-To: <CAKdAkRTWs1T7ZnMYABKtw2j3vfpVz5ngLdnehPcFoY4pz_jAoQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Duson Lin <dusonlin@emc.com.tw>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>

Hello Dmitry, thanks for the feedback.

On 1 September 2015 at 17:00, Dmitry Torokhov <dmitry.torokhov@gmail.co=
m> wrote:
> On Tue, Sep 1, 2015 at 12:53 PM, Jo=C3=A3o Paulo Rechi Vita
> <jprvita@gmail.com> wrote:
>> This ACPI ID present in the DSDT of the ASUS E202SA laptop.
>
> Can it be driven buy the standard hid-multitouch by any chance?
>

Without this change on v4.2 it is driven by i2c_hid, but behaves as a
regular mouse, so no absolute events, multitouch, tap to click etc. I
have not tried to use hid-multitouch with this touchpad, as I thought
hid-multitouch was a touchscreen driver. Is there any drawback in
having this supported by elan_i2c? Should I try a different approach?

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
