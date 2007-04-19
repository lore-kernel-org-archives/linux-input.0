From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [RFC 1/2] Input: ff, add FF_RAW effect
Date: Thu, 19 Apr 2007 00:58:10 -0400
Message-ID: <200704190058.11625.dtor@insightbb.com>
References: <210731960111436322@karneval.cz> <462688AB.4060707@gmail.com> <38b3b7c0704182125q1928c5barad21ed603088ab04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030812AbXDSE6N@vger.kernel.org>
In-Reply-To: <38b3b7c0704182125q1928c5barad21ed603088ab04@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: johann deneux <johann.deneux@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org, stenyak@gmail.com, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi,

On Thursday 19 April 2007 00:25, johann deneux wrote:
> On 4/18/07, Jiri Slaby <jirislaby@gmail.com> wrote:
> > johann deneux napsal(a):
> > > Jiri,
> > >
> > > Which solution did you chose to implement? From what I remember, we
> > > last discussed Dmitry's idea of specifying an axis for an effect, then
> > > combine several effects to achieve complex effects.
> >
> > I think you mean motor instead of axis, because I don't push real axes to
> > the devices, but motor's torques...
> >
> 
> Yes, sorry, I meant motor.
> 

I have been thinking about this and I don't think that exporting motor
data is a good idea, at least not in case of Phantom driver. The fact
that there are 3 motors is a hardware implementation detail and it
is not interesting for general application.

My understanding that the end result of controlling these 3 motors
is a force vector (I don't know if there is such english term, this
is a literal translation from russian) applied to user's hand.
If we are interested in using FF API we need to come up with a way
to express this effect without exposing implementation details of
one particular device.

-- 
Dmitry
