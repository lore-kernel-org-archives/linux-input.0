From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Input: add sensable phantom driver
Date: Wed, 7 Mar 2007 11:56:27 -0500
Message-ID: <d120d5000703070856of068f19k62c5a7ce1f829336@mail.gmail.com>
References: <2460126662758025813@fi.muni.cz>
	 <d120d5000703070647t223f8858i8c495dcc3e1378a2@mail.gmail.com>
	 <45EEEAA3.50009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <45EEEAA3.50009@gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, Greg KH <gregkh@suse.de>
List-Id: linux-input@vger.kernel.org

On 3/7/07, Jiri Slaby <jirislaby@gmail.com> wrote:
> Dmitry Torokhov napsal(a):
> > Hi Jiri,
>
> Hi.
>
> > On 3/7/07, Jiri Slaby <jirislaby@gmail.com> wrote:
> >> add sensable phantom driver
> > ...
> >
> > General question - can this driver use force-feedback mecahnisms
> > already present in kernel instead of exporting raw datastream to
> > userspace. What are shortcomings of kernels force-feedback
> > implemenattion that make it insufficient for phantom?
>
> I didn't even think about it, sorry. Does any problem with rate about 2kHz come
> on your mind before I'll try to rewrite it?

No, not really.

-- 
Dmitry
