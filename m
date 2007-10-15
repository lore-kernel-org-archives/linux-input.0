From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Re: [PATCH try #3] Input/Joystick Driver: add support AD7142 joystick driver
Date: Mon, 15 Oct 2007 20:27:43 +0200
Message-ID: <20071015182743.GA2529@Ahmed>
References: <1192459625.6215.17.camel@roc-laptop> <d120d5000710150848t1993b0aavbbc0cd7971e3ef3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000710150848t1993b0aavbbc0cd7971e3ef3e@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: bryan.wu@analog.com, Andrey Panin <pazke@donpac.ru>, Roel Kluin <12o3l@tiscali.nl>, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Jean Delvare <khali@linux-fr.org>
List-Id: linux-input@vger.kernel.org

On Mon, Oct 15, 2007 at 11:48:17AM -0400, Dmitry Torokhov wrote:
> Hi Bryan,
> 
> On 10/15/07, Bryan Wu <bryan.wu@analog.com> wrote:
> > +
> > +static int ad7142_thread(void *nothing)
> > +{
> > +       do {
> > +               wait_for_completion(&ad7142_completion);
> > +               ad7142_decode();
> > +               enable_irq(CONFIG_BFIN_JOYSTICK_IRQ_PFX);
> > +       } while (!kthread_should_stop());
> > +
> 
> No, this is not going to work well:
> - you at least need to reinitialize the completion before enabling
> IRQ, otherwise you will spin in a very tight loop
> - if noone would touch the joystick ad7142_clsoe would() block
> infinitely because noone would signal the completion and
> ad7142_thread() would never stop.
> 
> Completion is just not a good abstraction here... Please use work
> abstraction and possibly a separate workqueue.
> 

Bryan, I'm very interested in the technical advantage of using a completion
here.

In my _not-experienced_ opinion, I remember completions was created mainly for
"create_task, wait till task got finished, go on" case. Why using it in a
different context while workqueues was created for a similar situation to
ad7142 one (non-irq context bottom-half) ?

Regards,

-- 
Ahmed S. Darwish
HomePage: http://darwish.07.googlepages.com
Blog: http://darwish-07.blogspot.com
