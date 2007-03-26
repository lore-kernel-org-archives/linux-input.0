From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Fix sudden warps in mousedev
Date: Mon, 26 Mar 2007 14:42:06 -0700
Message-ID: <20070326144206.93805eeb.zaitcev@redhat.com>
References: <20070324001610.724a820a.zaitcev@redhat.com>
	<200703250134.03416.dtor@insightbb.com>
	<20070325111930.f6428509.zaitcev@redhat.com>
	<200703252319.39676.dtor@insightbb.com>
	<20070326121718.3940a579.zaitcev@redhat.com>
	<d120d5000703261230h1724e453je2c14769fc099ad3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000703261230h1724e453je2c14769fc099ad3@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, zaitcev@redhat.com
List-Id: linux-input@vger.kernel.org

On Mon, 26 Mar 2007 15:30:42 -0400, "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:

> Regarding the synaptics driver and scroll problem. Yesterday I
> scrolled twice through entire Remarque's "Spark of Life" off lib.ru
> (once with 0.14.2 and once with latest git pull) and did not see any
> scrollbar getting "stuck". Could it be newer xorg problem instead of
> individual driver problem? I am using whatever xorg was installed in
> FC3 which is somewhat dated... Also, could it be that the scroll issue
> happens only in a certain application?

It's not a "scroll" issue. The issue is that the "up" event is getting
lost. It can be observed with any GUI elements, such as buttons.
However, since the event is delivered upon any motion, there's no
harm done with a button. Needless to say, this is not application
specific. It may be GNOME specific though.

FC-3 is far too old to be a good reference. I don't even know if it
has a usable synaptics module in its pre-modular X. You may be looking
at very different software stack.

I don't think that you need to concern yourself with this too much
at present. If X11 people (e.g. Kristian) present evidence that kernel
fails to deliver an event, then we'll look at it. However it might
help if evtest continued to work when X11 reads from /dev/input/eventN.
It was an unpleasant surprise that it doesn't.

-- Pete
