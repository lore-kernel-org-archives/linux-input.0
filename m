From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Support for 3M multitouch panel
Date: Tue, 22 Dec 2009 10:56:29 -0800
Message-ID: <20091222185628.GA28392@core.coreip.homeip.net>
References: <20091211101258.CD35D951F5@smtp.lii-enac-fr> <20091211124226.GD17995@ibawizard.net> <20091211141038.0CBD8951F5@smtp.lii-enac.fr> <20091211223622.GA3067@core.coreip.homeip.net> <694242AB-D4DC-470D-916D-9ADB2B798FBA@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:53260 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662AbZLVS4p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Dec 2009 13:56:45 -0500
Received: by pwj9 with SMTP id 9so3948093pwj.21
        for <linux-input@vger.kernel.org>; Tue, 22 Dec 2009 10:56:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <694242AB-D4DC-470D-916D-9ADB2B798FBA@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>
Cc: ynezz@true.cz, linux-input@vger.kernel.org

Hi St=E9phane,

On Tue, Dec 22, 2009 at 07:00:49PM +0100, St=E9phane Chatty wrote:
> Hi Dmitry,
>
> I am working on the 3M driver and taking your comments into account (=
and=20
> applying them to the Stantum driver as well) but I have an question o=
n=20
> the comment below:
>
>>
>>> +struct mmm_finger {
>>> +	__s32 x, y;
>>> +	__u8 rank;
>>> +	int touch:1, valid:1;
>>> +};
>>
>> Does it make sense to turn access to touch and valid into
>> read-modify-write sequence?  Just change them to be 'bool's, it won'=
t
>> cause your structures to grow in size.
>>
>>> +struct mmm_data {
>>> +	struct mmm_finger f[10];
>>> +	__u8 curid, num;
>>> +	int touch:1, valid:1;
>>
>> Same as above.
>
> Why do you think a read-modify-write sequence would be better? in my =
=20
> mind these were just cached values, just like x and y.

I meant "read-modify-write" is worse.

To modify a bitfiled the processor has to fetch data from memory (or
cache if it is in cache) perform a logical operation on it, and store
it back in teh memory. With boolean occupying 1 byte, on most
architectures (older alphas is one exception I know of) var=3Dtrue can =
be
done by simple store, no need for "read-modify" part.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
