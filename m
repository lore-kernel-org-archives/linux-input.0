From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: Silence 'unused variable' warning in iforce joystick driver
Date: Fri, 31 Aug 2007 11:26:42 -0400
Message-ID: <d120d5000708310826q7ddf3514w55b3f4f0cca599ca@mail.gmail.com>
References: <200708310013.12347.jesper.juhl@gmail.com>
	 <alpine.LFD.0.999.0708310422200.31519@enigma.security.iitk.ac.in>
	 <200708310050.03786.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200708310050.03786.jesper.juhl@gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Satyam Sharma <satyam@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@ucw.cz>, Johann Deneux <johann.deneux@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-joystick@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Jesper,

On 8/30/07, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 31/08/2007, Satyam Sharma <satyam@infradead.org> wrote:
> ...
> >
> > Hmm, would this not still give a warning when JOYSTICK_IFORCE_USB=y?
>
> Arrgh, I messed that one up real good...  Thank you for your keen eye Satyam :-)
>
>
> > [ I didn't know mixing code and declarations (not at top of statement
> >   block) was accepted style in the kernel ... ]
> >
> It's not the common case, but this is certainly not the only place in the kernel where we do it.
>
>
> > IMHO either you should at least wrap that case inside a {} of its
> > own (so that the int status; is at top of a statement block), or else,
>
> Yeah, I should...
>
> > preferably, just add "__maybe_unused" to the first declaration that you
> > removed just now.
> >
>
> Here's an updated patch that actually works as intended.
>

I had a similar patch from Andrew Morton in my queue and it just got
merged. There should be no warning anymore.

-- 
Dmitry
