From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Canonical has own Ubuntu driver for ALPS 73 03 28 devices
Date: Tue, 21 Jun 2016 14:42:15 +0100
Message-ID: <20160621144215.333bd825@lxorguk.ukuu.org.uk>
References: <201606190143.46444@pali>
	<20160620101636.GA23462@infradead.org>
	<20160620102034.GI29844@pali>
	<CAE7LaDDBOqAaZP38tX4kuzd2108np+0xb0BgtcAoKFfo9QmikQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAE7LaDDBOqAaZP38tX4kuzd2108np+0xb0BgtcAoKFfo9QmikQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anthony Wong <anthony.wong@canonical.com>
Cc: Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Christoph Hellwig <hch@infradead.org>, Ben Gamari <ben@smart-cactus.org>, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Ben Morgan <Ben_Morgan@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

> The fix in the DKMS package you referenced was not written by
> Canonical but by ALPS, as it came from them I think it is reasonable
> they send it to upstream, isn't it? As you can see the patch is non-trivial.

You published it on to milliosn of users, you'd think also mentioning its
existence upstream would have been easy enough.

> After we got the patch from ALPS, we had follow-up conversation a few
> times with our contacts at Taiwan and asked if they would upstream it,
> but unfortunately to no avail. I am as desperate as you if the fix
> cannot land in mainline, which means many Linux users will not benefit
> from it.  We also had opened this bug [1] for this particular issue,
> there is nothing to hide. If there is any code written by us, we
> happily submit them upstream.

Other vendors and users regularly upstream driver code that lurks in
third party repositories or amidst the grues in the dark smelly corners of
the Android underworld. (and contrary to Christoph's comment Canonical are
angels compared with a lot of the Android world)

I can see why you wouldn't want to submit it if ALPS were
going to, but really - not even mentioning it upstream when there was
other work going on was unfortunate. A single Canonical email saying
"You might want to look at the ALPS driver at URL" would have saved all
the wasted effort.

It's also good common sense behaviour - in this case there is no API
difference but vendors who sit on stuff get burned when we merge an
alternative piece of code.

Alan
