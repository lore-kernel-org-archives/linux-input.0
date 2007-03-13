From: "Jiri Slaby" <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] Input: add sensable phantom driver
Date: Tue, 13 Mar 2007 17:19:04 +0100
Message-ID: <4af2d03a0703130919nb4893b1ja9ec795dcf4bf53c@mail.gmail.com>
References: <2460126662758025813@fi.muni.cz>
	 <d120d5000703070647t223f8858i8c495dcc3e1378a2@mail.gmail.com>
	 <45EEEAA3.50009@gmail.com>
	 <d120d5000703070856of068f19k62c5a7ce1f829336@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000703070856of068f19k62c5a7ce1f829336@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, Greg KH <gregkh@suse.de>, Anssi Hannula <anssi.hannula@gmail.com>
List-Id: linux-input@vger.kernel.org

Cc: Anssi Hannula <anssi.hannula@gmail.com>

On 3/7/07, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 3/7/07, Jiri Slaby <jirislaby@gmail.com> wrote:
> > Dmitry Torokhov napsal(a):
> > > Hi Jiri,
> >
> > Hi.
> >
> > > On 3/7/07, Jiri Slaby <jirislaby@gmail.com> wrote:
> > >> add sensable phantom driver
> > > ...
> > >
> > > General question - can this driver use force-feedback mecahnisms
> > > already present in kernel instead of exporting raw datastream to
> > > userspace. What are shortcomings of kernels force-feedback
> > > implemenattion that make it insufficient for phantom?
> >
> > I didn't even think about it, sorry. Does any problem with rate about 2kHz come
> > on your mind before I'll try to rewrite it?
>
> No, not really.

Hmm, after going through input and ff layer, I figured out, that it's
possible to pass only a direction to constant effect. I think, there
is no possibility to pass 3D force (or vector) to the ff layer, isn't
it?

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
