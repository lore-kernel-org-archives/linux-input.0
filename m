From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: Fix sudden warps in mousedev
Date: Mon, 26 Mar 2007 21:14:44 -0400
Message-ID: <200703262114.45287.dtor@insightbb.com>
References: <20070324001610.724a820a.zaitcev@redhat.com> <d120d5000703261230h1724e453je2c14769fc099ad3@mail.gmail.com> <20070326144206.93805eeb.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070326144206.93805eeb.zaitcev@redhat.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, Peter Osterlund <petero2@telia.com>
List-Id: linux-input@vger.kernel.org

On Monday 26 March 2007 17:42, Pete Zaitcev wrote:
> On Mon, 26 Mar 2007 15:30:42 -0400, "Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:
> 
> > Regarding the synaptics driver and scroll problem. Yesterday I
> > scrolled twice through entire Remarque's "Spark of Life" off lib.ru
> > (once with 0.14.2 and once with latest git pull) and did not see any
> > scrollbar getting "stuck". Could it be newer xorg problem instead of
> > individual driver problem? I am using whatever xorg was installed in
> > FC3 which is somewhat dated... Also, could it be that the scroll issue
> > happens only in a certain application?
> 
> It's not a "scroll" issue. The issue is that the "up" event is getting
> lost. It can be observed with any GUI elements, such as buttons.
> However, since the event is delivered upon any motion, there's no
> harm done with a button. Needless to say, this is not application
> specific. It may be GNOME specific though.

Could be as I am KDE user.

> 
> FC-3 is far too old to be a good reference. I don't even know if it
> has a usable synaptics module in its pre-modular X. You may be looking
> at very different software stack.
>

See above. _My_ box certainly has usable synaptics module.
 
> I don't think that you need to concern yourself with this too much
> at present. If X11 people (e.g. Kristian) present evidence that kernel
> fails to deliver an event, then we'll look at it. However it might
> help if evtest continued to work when X11 reads from /dev/input/eventN.
> It was an unpleasant surprise that it doesn't.
> 

The driver grabs tochpad with EVIOCGRAB ioctl to prevent input events
from bveing delivered to X through /dev/input/mice which is still in
whidespread use. That's why evtest does not work. We could as Peter
(CCed) to implement an option to turn off grabbing so users who don't
use mousedev multiplexor can use evtest and other commands.

-- 
Dmitry
