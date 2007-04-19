From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFC 1/2] Input: ff, add FF_RAW effect
Date: Thu, 19 Apr 2007 12:02:21 -0400
Message-ID: <d120d5000704190902o60aa4b19y77728585e22b2e84@mail.gmail.com>
References: <210731960111436322@karneval.cz> <462688AB.4060707@gmail.com>
	 <38b3b7c0704182125q1928c5barad21ed603088ab04@mail.gmail.com>
	 <200704190058.11625.dtor@insightbb.com> <46278CDD.2000007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <46278CDD.2000007@gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: johann deneux <johann.deneux@gmail.com>, linux-kernel@vger.kernel.org, stenyak@gmail.com, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 4/19/07, Jiri Slaby <jirislaby@gmail.com> wrote:
> Dmitry Torokhov napsal(a):
> > I have been thinking about this and I don't think that exporting motor
> > data is a good idea, at least not in case of Phantom driver. The fact
> > that there are 3 motors is a hardware implementation detail and it
> > is not interesting for general application.
>
> Ok, so what about torques (despite it's still something like FF_RAW or motor
> descriptor)? It seems not to be so bad called effect name -- not only
> phantom uses torques on motors as an unit of force, for example I get this
> by quick googling:
> http://www.caip.rutgers.edu/~bouzit/lrp/glove.html
> They use there some motors with 14 torque values too, so the phantom isn't
> the only device which uses this approach.
>
> > My understanding that the end result of controlling these 3 motors
>
> Actually there is also a version with 6 motors :).
>
> > is a force vector (I don't know if there is such english term, this
> > is a literal translation from russian) applied to user's hand.
>
> Better say torques vector. You must compute a torque for each place from the
> 3d (or bigger) vector of forces in different way for each device that exists
> -- this means forces are not independent unit, torques are in the meaning of
> layer which doesn't care about what is connected above and below it.
>
> > If we are interested in using FF API we need to come up with a way
> > to express this effect without exposing implementation details of
> > one particular device.
>
> Still, torques are better named raw/motor values, which goes to the device
> and I'm sceptic about inventing something class-better than this.
>

Well, I guess we need to make a decision whether moving this kind of
devices into a force feedback layer is possible or whether every
device needs to have an application specifically tailored to that
particular device.

If we say that it is feasible to plug a device into FF layer then we
must not expose hardware implementation details. That means that
device-sepcific translation between 3d vector of forces into motor
torques must be done by the driver itself.

For devices that require tailored application (for example that glove
- I am not sure how a generic application could control it) old
phantom way of controlling via ioctl will suffice. The device may
still use input layer to report back coordinates.

-- 
Dmitry
