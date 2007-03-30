From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: FF layer restrictions [Was: [PATCH 1/1] Input: add sensable phantom driver]
Date: Fri, 30 Mar 2007 12:46:41 -0400
Message-ID: <d120d5000703300946k4268dfa0kadd3bf3094accd09@mail.gmail.com>
References: <2460126662758025813@fi.muni.cz> <460983D6.7070409@gmail.com>
	 <38b3b7c0703271434u2fddc4d1jc2b9af097e9c95b2@mail.gmail.com>
	 <200703272308.34441.dtor@insightbb.com> <460AE933.6010209@gmail.com>
	 <460AEA8C.2050102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <460AEA8C.2050102@gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: johann deneux <johann.deneux@gmail.com>, "=?ISO-8859-1?Q?\"STenyaK_(Bruno_Gonz=E1lez)\"?=" <stenyak@gmail.com>, Anssi Hannula <anssi.hannula@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 3/28/07, Jiri Slaby <jirislaby@gmail.com> wrote:
> Jiri Slaby napsal(a):
> > Dmitry Torokhov napsal(a):
> >> On Tuesday 27 March 2007 17:34, johann deneux wrote:
> >>> What about adding a member to ff_effect which would be the number of the motor?
> >>> We can't change the layout of ff_effect too much though, so we have to
> >>> find unused bits and put them to work.
> >>>
> >>> For instance, we could replace
> >>>
> >>> __u16 type;
> >>>
> >>> by
> >>>
> >>> __u8 motor;
> >>> __u8 type;
> >>>
> >> Splitting type field seems to be a good idea.
> >
> > Maybe stupid question, but what about endianness + backward compatibility?
> > If we split it into motor,type sequence, it would break LE (untouched BE),
> > if we do type,motor, it is OK for LE (broken BE).
>
> Aha, and the question is: do
>
> #ifdef __BIG_ENDIAN
> #else
> #endif
>
> ?
>

I am so tempted to say "screw BE, there is not many users of FF layer"
but I am afraid we will have to do that #ifdef-fu.

-- 
Dmitry
