From: "johann deneux" <johann.deneux@gmail.com>
Subject: Re: [RFC 1/2] Input: ff, add FF_RAW effect
Date: Wed, 18 Apr 2007 22:00:53 +0200
Message-ID: <38b3b7c0704181300p78df84f3h8fd4e74428d4e4d8@mail.gmail.com>
References: <210731960111436322@karneval.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <210731960111436322@karneval.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@insightbb.com>, stenyak@gmail.com, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Jiri,

Which solution did you chose to implement? From what I remember, we
last discussed Dmitry's idea of specifying an axis for an effect, then
combine several effects to achieve complex effects.
The implementation would specify the axis using the upper bits of the
effect type.

The patches you have sent seem to implement an easier, but in my
opinion inferior solution. If this FF_RAW effect does not have
semantics which are meaningful for other kinds of devices, I think
using the FF API is not a good idea.


On 4/17/07, Jiri Slaby <jirislaby@gmail.com> wrote:
> So fellows, what about these ones?
>
> --
>
> ff, add FF_RAW effect
>
> Add new FF_RAW effect for devices such Phantom. The new model has up to 6DOF
> torque force feedback independent on any 3d-or-so value.
>
