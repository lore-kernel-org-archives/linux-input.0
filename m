From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [RFC 1/2] Input: ff, add FF_RAW effect
Date: Wed, 18 Apr 2007 23:07:55 +0200
Message-ID: <462688AB.4060707@gmail.com>
References: <210731960111436322@karneval.cz> <38b3b7c0704181300p78df84f3h8fd4e74428d4e4d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <38b3b7c0704181300p78df84f3h8fd4e74428d4e4d8@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: johann deneux <johann.deneux@gmail.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@insightbb.com>, stenyak@gmail.com, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

johann deneux napsal(a):
> Jiri,
> 
> Which solution did you chose to implement? From what I remember, we
> last discussed Dmitry's idea of specifying an axis for an effect, then
> combine several effects to achieve complex effects.

I think you mean motor instead of axis, because I don't push real axes to
the devices, but motor's torques...

> The implementation would specify the axis using the upper bits of the
> effect type.

Ok, if this is preferred, I'll post it with the const of having more context
switches for a single effect.

This was just a realization of the idea how I though it with the
quick'n'dirty FF_RAW.

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
 B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
