From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: Re: [PATCH v3 1/4] drm/bridge: sil_sii8620: depend on INPUT
 instead of selecting it.
Date: Fri, 29 Mar 2019 02:22:46 -0700
Message-ID: <20190329092246.GA7306@innovation.ch>
References: <20190327014807.7472-1-ronald@innovation.ch>
 <CGME20190327014824epcas2p1f79a41c58f76150f7324169805f506f0@epcas2p1.samsung.com>
 <20190327014807.7472-2-ronald@innovation.ch>
 <9fd8af5b-20ed-5dca-7d5c-98f2926b9b0c@samsung.com>
 <20190328000743.GB24753@innovation.ch>
 <35bf8a61-b84c-3aae-00de-14637d37547b@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <35bf8a61-b84c-3aae-00de-14637d37547b@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
List-Id: linux-input@vger.kernel.org


On Thu, Mar 28, 2019 at 12:48:39PM +0100, Andrzej Hajda wrote:
> On 28.03.2019 01:07, Life is hard, and then you die wrote:
> >
> > On Wed, Mar 27, 2019 at 03:13:37PM +0100, Andrzej Hajda wrote:
> >> +cc: dri-devel
[snip]
> > It seems your mail client doesn't like me :-) I got neither of your
> > responses. Sorry, I should've checked the archives when I didn't hear
> > anything. In any case thank you for your review, and I will update
> > that patch and send out a new version shortly.
> 
> I see where is the problem: Your mail client (mutt I suppose) sets
> Mail-Followup-To header to all recipients (To and Cc) without the
> sender. And my client (thunderbird) after pressing "Reply-All" checks
> for Mail-Followup-To field, if present it uses only it to set
> recipients, so in your case it does not response to the original author.
> 
> I do not know which mail client works incorrectly in this case, but for
> sure it is not what we want :)
> 
> I do not know how to solve the issue in thunderbird, maybe mutt is more
> configurable?

Thanks for debugging this! I'm sorry, but it looks like this was an
error on my part. So for anybody else using mutt: by default, mutt
will add a Mail-Followup-To header without your own address when
sending mail to any lists you are subscribed to, as defined by the
'subscribe' command (to avoid receiving replies in duplicate, i.e.
once via to/cc and once via the list). Unfortunately I was using a
regex there that included all freedesktop.org lists, not just ones I'm
actually subscribed to, and hence it thought I was subscribed
dri-devel too, leading to the this screwup.

Apologies for this - I guess even after more than 2 decades of mutt
and mailing lists I still manage to not know all its ins and outs.
But it should be fixed now.


  Cheers,

  Ronald
