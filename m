From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH 09/12] HID: wiimote: Add wiimote input button parser
Date: Wed, 29 Jun 2011 14:43:31 +0200
Message-ID: <BANLkTi=S-0W-iZ_S-t4t_cxe5WBkB7mH7A@mail.gmail.com>
References: <1309185013-484-1-git-send-email-dh.herrmann@googlemail.com>
	<1309185013-484-9-git-send-email-dh.herrmann@googlemail.com>
	<4f32c31e-7cc0-40b8-b2a4-0f92a0f90423@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:36028 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755439Ab1F2Mnd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 08:43:33 -0400
Received: by vxb39 with SMTP id 39so836567vxb.19
        for <linux-input@vger.kernel.org>; Wed, 29 Jun 2011 05:43:32 -0700 (PDT)
In-Reply-To: <4f32c31e-7cc0-40b8-b2a4-0f92a0f90423@email.android.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, padovan@profusion.mobi, jkosina@suse.cz, oliver@neukum.org

On Tue, Jun 28, 2011 at 7:52 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> David Herrmann <dh.herrmann@googlemail.com> wrote:
>
>>+ =A0 =A0 =A0input_event(wdata->input, EV_KEY, wiiproto_keymap[WIIPRO=
TO_KEY_LEFT],
>>+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!!(payload[0] & 0x01));
>
> input_report_key()
>
>
>>+ =A0 =A0 =A0input_event(wdata->input, EV_SYN, SYN_REPORT, 0);
>
> input_sync()
>
> Thanks.
>
>
> --
> Dmitry

Thanks, I've fixed that.
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
