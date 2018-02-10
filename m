From: Jonathan Cameron <jic23-tko9wxEg+fIOOJlXag/Snyp2UmYkHbXO@public.gmane.org>
Subject: Re: Software evolution around =?UTF-8?B?4oCcY2hlY2twYXRjaC5wbA==?=
 =?UTF-8?B?4oCdPw==?=
Date: Sat, 10 Feb 2018 15:57:34 +0000
Message-ID: <20180210155734.708d01b6@archlinux>
References: <0406765c-bdd1-1a82-cf66-1c248063ae4f@users.sourceforge.net>
        <20180204112346.0977e938@archlinux>
        <9420fc82-1a37-3601-bafe-f57ef953bfcd@users.sourceforge.net>
        <87DF341A-1356-4B1B-8D25-14D5B0AAB01D@jic23.retrosnub.co.uk>
        <f008911b-c595-6e0f-d85f-076e994ae7db@users.sourceforge.net>
        <20180210145336.233c721d@archlinux>
        <1518274783.6579.2.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1518274783.6579.2.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: SF Markus Elfring <elfring-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sat, 10 Feb 2018 06:59:43 -0800
Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org> wrote:

> On Sat, 2018-02-10 at 14:53 +0000, Jonathan Cameron wrote:
> > While it would be great to improve checkpatches false
> > positive rate, it's very nature as a string matcher makes
> > this hard.  
> 
> true.
> 
> what are the false positives you see?
> 
This particular case is only 'sort of' a false positive
in the warning that a message printed on a memory allocation
failure 'may' not add any information over the generic case.

Very hard to judge on whether it is useful to know more than
an allocation failed somewhere or not.

Message makes this clear:
>“WARNING: Possible unnecessary 'out of memory' message”
>(from the script “checkpatch.pl”)  

We also have the balance between any changes to existing code
adding 'some' maintenance overhead vs changing this stuff
in a new driver - which is what checkpatch is really intended
for.

So I think checkpatch is striking the right balance here in
how it warns.  Obviously if it could assess the text
and come to an informed decision that would be great but
we are some way from that ;)

Jonathan
