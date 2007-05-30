From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: Annoying keys on AT keyboards
Date: Tue, 29 May 2007 23:29:02 -0400
Message-ID: <200705292329.03122.dtor@insightbb.com>
References: <1180477268.3030.111.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1180477268.3030.111.camel@cookie.hadess.net>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: Bastien Nocera <hadess@hadess.net>
List-Id: linux-input@vger.kernel.org

Hi,

On Tuesday 29 May 2007 18:21, Bastien Nocera wrote:
> Heya,
> 
> My Dell laptop has a good bunch of keys that show this behaviour:
> Apr 25 11:23:10 snoogens kernel: atkbd.c: Unknown key pressed
> (translated set 2,
> code 0x87 on isa0060/serio0).
> Apr 25 11:23:10 snoogens kernel: atkbd.c: Use 'setkeycodes e007 <keycode>' to
> make it known.
> 
> Given that all Dell laptops generate this kind of behaviour, that all
> the keys match on all the models (I know about),

Hmm, mine does not generate e007...

> would it be 
> possible/sane to add some code to the AT keyboard driver to handle those
> keys when the DMI matches?

No, because it is not guaranteed that user will not plug external AT
keyboard with different keys assigned to the same keycodes. For drivers
like atkbd that may drive several devices at once DMI solution will
not work reliably (but it will work and is used for fixed hardware,
such as wistron_btns).

I just put:

setkeycodes e001 171
setkeycodes e002 172
setkeycodes e003 187
setkeycodes e004 189

in my rc.local several years ago and that is it. Distributions may do
that for users automatically during installation.

-- 
Dmitry
