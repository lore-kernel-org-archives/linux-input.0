From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: FF layer restrictions [Was: [PATCH 1/1] Input: add sensable phantom
 driver]
Date: Thu, 29 Mar 2007 00:22:04 +0200
Message-ID: <460AEA8C.2050102@gmail.com>
References: <2460126662758025813@fi.muni.cz> <460983D6.7070409@gmail.com> <38b3b7c0703271434u2fddc4d1jc2b9af097e9c95b2@mail.gmail.com> <200703272308.34441.dtor@insightbb.com> <460AE933.6010209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <460AE933.6010209@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: johann deneux <johann.deneux@gmail.com>, =?UTF-8?B?IlNUZW55YUsgKEJydW4=?= =?UTF-8?B?byBHb256w6FsZXopIg==?= <stenyak@gmail.com>, Anssi Hannula <anssi.hannula@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Jiri Slaby napsal(a):
> Dmitry Torokhov napsal(a):
>> On Tuesday 27 March 2007 17:34, johann deneux wrote:
>>> What about adding a member to ff_effect which would be the number of the motor?
>>> We can't change the layout of ff_effect too much though, so we have to
>>> find unused bits and put them to work.
>>>
>>> For instance, we could replace
>>>
>>> __u16 type;
>>>
>>> by
>>>
>>> __u8 motor;
>>> __u8 type;
>>>
>> Splitting type field seems to be a good idea.
> 
> Maybe stupid question, but what about endianness + backward compatibility?
> If we split it into motor,type sequence, it would break LE (untouched BE),
> if we do type,motor, it is OK for LE (broken BE).

Aha, and the question is: do

#ifdef __BIG_ENDIAN
#else
#endif

?

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
 B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

Hnus <hnus@fi.muni.cz> is an alias for /dev/null
