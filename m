From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] input: mt: Add an envelope tool type
Date: Thu, 09 Dec 2010 02:51:25 +0100
Message-ID: <4D00361D.4000603@euromail.se>
References: <1291721340-22652-1-git-send-email-rydberg@euromail.se> <4CFFC3C2.1080905@canonical.com> <AANLkTikmomm2hd7AAJMTnY+=J2wPyVvodv2Ft0jFe7w2@mail.gmail.com> <20101208235805.GE15294@core.coreip.homeip.net> <AANLkTink9aX=dV-+n5=2BpPF34kSZGSQQ6x2tUNJ8eSM@mail.gmail.com> <AANLkTi=rjbzX9zzx-xvvhu7osKU8eUiPxi2=z=9H6YwJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=rjbzX9zzx-xvvhu7osKU8eUiPxi2=z=9H6YwJ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chase Douglas <chase.douglas@canonical.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 12/09/2010 02:38 AM, Mohamed Ikbel Boulabiar wrote:

> On Thu, Dec 9, 2010 at 1:06 AM, Ping Cheng <pinglinux@gmail.com> wrote:
>> No, we are not talking about non-rectangular shape here. Envelop is
>> always a rectangle. By rectangle above, I meant 2 touches.
>>
>> An envelop that includes number of touches offers us more information
>> than a rectangle does
> 
> Can we have more information that just a rect ? An ellipse for exemple.
> Can we get this information at least from synaptics touchpads?


Unfortunately not. Chris Bagwell and myself have been experimenting with quite a
few different approaches to extract touch information from the synaptics pads.
The present approach, to extract the bounding rectangle, is the best we can do,
I am afraid - at least with the information unveiled in Takashi's original
patch. In particular, rotation information is not reliably extractable.

Henrik
