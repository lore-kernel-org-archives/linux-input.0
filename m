From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Problem with appletouch driver in Linux version 2.6.23-rc7
Date: Wed, 26 Sep 2007 16:13:00 -0400
Message-ID: <d120d5000709261313j16f9612fx7d445b707df7784b@mail.gmail.com>
References: <46F54D92.7000300@tng.de>
	 <d120d5000709240540ic91832em277a6bcbb399cd45@mail.gmail.com>
	 <1190638998.12782.0.camel@localhost> <46F7BA08.6000201@tng.de>
	 <1190836596.1359.33.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1190836596.1359.33.camel@localhost>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Thomas Rohwer <tr@tng.de>, linux-input@atrey.karlin.mff.cuni.cz, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-input@vger.kernel.org

On 9/26/07, Soeren Sonnenburg <kernel@nn7.de> wrote:
>
> On Mon, 2007-09-24 at 15:22 +0200, Thomas Rohwer wrote:
> > Hello,
> >
> > > could you please re-send the patch? I for some reason have yet to see
> > > it ...
> >
> > here it is again, adressing also the comments from Dmitry.
>
> Thomas, Matthew and Dmitry,
>
> I think there is another bug in this. I mean whenever a mouse button is
> pressed or the mouse is moved the counter should be reset - no?
>
> Currently the idle counter is just increased...
>
> I mean shouldn't it be
>
> if (x || y || key)
>        dev->idlecount=0;
>
> if (!x && !y && !key)
> {
>        dev->idlecount++;
>        if (dev->idlecount == 10) {
>                dev->valid = 0;
>                schedule_work(&dev->work);
>        }
> }
>

Yes, I think you are right. I guess one could trigger an extra reset
by pressing the button repeatedly witout touching the pad. But because
we won't do reset while the button is pressed we'll never lose release
event.

I guess we want to fix it but it can wait for 2.6.24. A patch woudl be
appreciated.

Thanks!

-- 
Dmitry
