From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH v3 4/5] hid-multitouch: refactor initialization of ABS_MT_ORIENTATION
Date: Mon, 21 Mar 2011 14:32:16 +0100
Message-ID: <AANLkTimx6YR_ByHDeqyMmSuE659xyRNkaAoOffTp_RgC@mail.gmail.com>
References: <1300454876-5017-1-git-send-email-benjamin.tissoires@enac.fr>
	<1300454876-5017-5-git-send-email-benjamin.tissoires@enac.fr>
	<20110321090240.GD3784@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33639 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab1CUNcS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Mar 2011 09:32:18 -0400
In-Reply-To: <20110321090240.GD3784@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

On Mon, Mar 21, 2011 at 10:02, Henrik Rydberg <rydberg@euromail.se> wro=
te:
> On Fri, Mar 18, 2011 at 02:27:55PM +0100, Benjamin Tissoires wrote:
>> No semantic changes, it's just easier to read the code.
>
> Please augment this commit message.

How about:

"The way the input_set_abs_params was called for the new composite
field ABS_MT_ORIENTATION was not very clear at second reading.
We can remove the non-necessary call to set_abs and use the simple
call to input_set_abs_params."

Cheers,
Benjamin

>
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> Reviewed-by: St=E9phane Chatty <chatty@enac.fr>
>> ---
>
> Thanks,
> Henrik
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
