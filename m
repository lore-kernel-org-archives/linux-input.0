From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [RFC 1/2] Input: ff, add FF_RAW effect
Date: Mon, 23 Apr 2007 21:30:15 +0200
Message-ID: <462D0947.3090109@gmail.com>
References: <210731960111436322@karneval.cz> <462688AB.4060707@gmail.com>	 <38b3b7c0704182125q1928c5barad21ed603088ab04@mail.gmail.com>	 <200704190058.11625.dtor@insightbb.com> <46278CDD.2000007@gmail.com> <d120d5000704190902o60aa4b19y77728585e22b2e84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000704190902o60aa4b19y77728585e22b2e84@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: johann deneux <johann.deneux@gmail.com>, linux-kernel@vger.kernel.org, stenyak@gmail.com, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov napsal(a):
> For devices that require tailored application (for example that glove
> - I am not sure how a generic application could control it) old
> phantom way of controlling via ioctl will suffice. The device may
> still use input layer to report back coordinates.

And how about the individual FF ioctl? Did you mean registering another
chardev, which is totally ugly in my eyes or augment evdev.c to support
driver specific ioctl? i.e. either add another 'E' ioctl with pointer to
struct { code, value } as arg param or changing
if (_IOC_TYPE(cmd) != 'E'))
	return -EINVAL;
to sth. like
if (_IOC_TYPE(cmd) != 'E'))
	return dev->ioctl ? dev->ioctl(file, cmd, p) : -EINVAL;
in evdev_ioctl_handler, which is acceptable?

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
 B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
