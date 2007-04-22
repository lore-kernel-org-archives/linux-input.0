From: "Jiri Slaby" <jirislaby@gmail.com>
Subject: Re: [RFC 1/2] Input: ff, add FF_RAW effect
Date: Sun, 22 Apr 2007 14:57:44 +0200
Message-ID: <4af2d03a0704220557u5d6368a2t13878b73bf9dbe64@mail.gmail.com>
References: <210731960111436322@karneval.cz> <462688AB.4060707@gmail.com>
	 <38b3b7c0704182125q1928c5barad21ed603088ab04@mail.gmail.com>
	 <200704190058.11625.dtor@insightbb.com> <46278CDD.2000007@gmail.com>
	 <d120d5000704190902o60aa4b19y77728585e22b2e84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000704190902o60aa4b19y77728585e22b2e84@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: johann deneux <johann.deneux@gmail.com>, linux-kernel@vger.kernel.org, stenyak@gmail.com, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On 4/19/07, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 4/19/07, Jiri Slaby <jirislaby@gmail.com> wrote:
> > Dmitry Torokhov napsal(a):
> > > If we are interested in using FF API we need to come up with a way
> > > to express this effect without exposing implementation details of
> > > one particular device.
> >
> > Still, torques are better named raw/motor values, which goes to the device
> > and I'm sceptic about inventing something class-better than this.
> >
>
> Well, I guess we need to make a decision whether moving this kind of
> devices into a force feedback layer is possible or whether every
> device needs to have an application specifically tailored to that
> particular device.
>
> If we say that it is feasible to plug a device into FF layer then we
> must not expose hardware implementation details. That means that
> device-sepcific translation between 3d vector of forces into motor
> torques must be done by the driver itself.

Hmm, it's 3d at minimum (the glove has 14 torque points, phantom up to
6), I think we won't be able to make the transition in independent way
due to unspecified meaning of the torques.

> For devices that require tailored application (for example that glove
> - I am not sure how a generic application could control it) old
> phantom way of controlling via ioctl will suffice. The device may
> still use input layer to report back coordinates.

Ok, nobody seems to have an idea, I'm going to avoid FF layer in the
code and hope this is the final change ;).

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
