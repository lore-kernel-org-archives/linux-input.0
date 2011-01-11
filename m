From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH v2] hid-multitouch: changes from the review process
Date: Tue, 11 Jan 2011 18:38:24 +0100
Message-ID: <AANLkTin86WMvEpNAm2T8wR=GgUBtYqoqGJxZm7hKnEoE@mail.gmail.com>
References: <1294760754-7885-1-git-send-email-benjamin.tissoires@enac.fr>
	<20110111173511.GA3461@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49658 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab1AKRi0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Jan 2011 12:38:26 -0500
In-Reply-To: <20110111173511.GA3461@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jan 11, 2011 at 6:35 PM, Henrik Rydberg <rydberg@bitmath.org> w=
rote:
> On Tue, Jan 11, 2011 at 04:45:54PM +0100, Benjamin Tissoires wrote:
>> * amended Kconfig (PixCir and Hanvon are the same panel but with
>> =A0 different name)
>> * insert field name in mt_class and retrieving it in mt_probe
>> * add 2 quirks: MT_QUIRK_VALID_IS_INRANGE, MT_QUIRK_VALID_IS_CONFIDE=
NCE,
>> =A0 in order to find the field "valid"
>> * inlined slot_is_contactid and slot_is_contact_number
>> * cosmetics changes (tabs and comments)
>> * do not send unnecessary properties once the touch is up
>>
>> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>
> There are some syntactic suboptimalities in the resulting file that
> perhaps could be fixed, but content-wise, I have nothing further. So,
> given that it actually works,
>
> Acked-by: Henrik Rydberg <rydberg@euromail.se>
>
> Thank you very much for your work, Benjamin.

Thanks for the review Henrik,

Cheers,
Benjamin
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
