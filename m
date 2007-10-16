From: "Bryan Wu" <cooloney.lkml@gmail.com>
Subject: Re: [PATCH try #3] Input/Joystick Driver: add support AD7142 joystick driver
Date: Tue, 16 Oct 2007 13:51:53 +0800
Message-ID: <386072610710152251k66529210x9311d2f2b202ad2b@mail.gmail.com>
References: <1192459625.6215.17.camel@roc-laptop>
	 <d120d5000710150848t1993b0aavbbc0cd7971e3ef3e@mail.gmail.com>
	 <386072610710151024s13e9c16qd7c974cde8000a9@mail.gmail.com>
	 <d120d5000710151040n2dbea5cbt515d3df87d5d19ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000710151040n2dbea5cbt515d3df87d5d19ed@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: bryan.wu@analog.com, Andrey Panin <pazke@donpac.ru>, Roel Kluin <12o3l@tiscali.nl>, "Ahmed S. Darwish" <darwish.07@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Jean Delvare <khali@linux-fr.org>
List-Id: linux-input@vger.kernel.org

On 10/16/07, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 10/15/07, Bryan Wu <cooloney.lkml@gmail.com> wrote:
> > On 10/15/07, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > >
> > > Completion is just not a good abstraction here... Please use work
> > > abstraction and possibly a separate workqueue.
> >
> > Yes, I agree with you now, although I have a little concern about the
> > possibility of big delay introduced by workqueue.
> >
>
> Having a separate workqueue should isolate the driver from users
> hogging keventd. Otherwise the speed should be pretty much the same as
> with a kthread.
>

Does this driver need the create a new kthread instead of keventd?
I think keventd might be sufficient for this driver.

> >
> > Thanks a lot for you kindly review.
> > I will resend update patch later.
>
> Thank you for not getting frustrated with all my change requests.

Oh, your help is very useful. It encourages us to send out our drivers
to LKML.

> Btw,
> blackfin keypad driver is in my tree and should be in mainline once
> Linus does the pull I requested.
>

Thanks again, I noticed it was merged already.

-Bryan Wu
