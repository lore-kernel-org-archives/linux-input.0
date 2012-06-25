From: Dharam Kumar <dharam.kumar.gupta@gmail.com>
Subject: Re: Missing Key-codes from <linux/input.h> file
Date: Mon, 25 Jun 2012 20:15:39 +0530
Message-ID: <CAOt5+pTm5mzGjnOWRdqDZY+tFha4jDazZ35F04r9gAdJV-D9Jw@mail.gmail.com>
References: <CAOt5+pRZ=qqEZ2Ra3yFbLqoHhDGFkzHs4cEXvFv5trbukd4MdA@mail.gmail.com>
 <20120625142606.GA13212@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:56272 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632Ab2FYOqA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 10:46:00 -0400
Received: by lbbgm6 with SMTP id gm6so6593551lbb.19
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 07:45:59 -0700 (PDT)
In-Reply-To: <20120625142606.GA13212@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@redhat.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Mon, Jun 25, 2012 at 7:56 PM, Jarod Wilson <jarod@redhat.com> wrote:
> On Mon, Jun 25, 2012 at 07:39:25PM +0530, Dharam Kumar wrote:
>> Hi,
>> I'm working on a module which is an input device and hence it needs =
to
>> report certain key events.
>>
>> While browsing through the <linux/input.h>, I did find most of the
>> key-codes(which I need to use) already defined but not all.
>>
>> Few of the KEY_xxx which i could not find are:
>>
>> a.) A Key for going to the previous channel.
>
> I believe that's what this one is intended for:
>
> #define KEY_PREVIOUS =A0 =A0 =A0 =A0 =A0 =A00x19c
>

Hmm..I looked at it, but i was not sure ,whether it is the right key
code for the 'Previous channel'.
To be specific about what the key is supposed to do:
"Select the channel used before most recent new channel selection."
Also, there is another define:
#define KEY_LAST                     0x195  /* Recall last */
confusing...No?

>> b.) Keys for Moving upper-right, lower-right, upper-left and
>> lower-left direction(probably a GUI(or a grid of icons),where you mo=
ve
>> diagonally)
>
> Sounds a bit like joystick functionality, which already exists.

Will you please be bit more specfic? Which keys/defines exactly you
are talking about?
Apologies for me being so naive. :)
>
>> d.) A key for Subpicture (this 'subpicture' key is defined in CEA-93=
1C).
>
> Could have sworn there was a picture-in-picture button, which may or =
may
> not be the same thing, but I don't see it now...
>
> --
> Jarod Wilson
> jarod@redhat.com
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
