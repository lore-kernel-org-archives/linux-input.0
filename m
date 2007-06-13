From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [patch] hid: fix autocentering of PID devices
Date: Wed, 13 Jun 2007 23:42:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0706132340560.23280@twin.jikos.cz>
References: <466FDC51.5030703@gmail.com> <Pine.LNX.4.64.0706131746020.23280@twin.jikos.cz>
 <46705CBD.5040302@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <46705CBD.5040302@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-input@atrey.karlin.mff.cuni.cz, Diogo Kastrup <dk@bighost.com.br>
List-Id: linux-input@vger.kernel.org

On Thu, 14 Jun 2007, Anssi Hannula wrote:

> > do you have any idea what caused this to happen in 2.6.21 and not in 
> > earlier versions?
> Nope. Do you think it would be useful for me to bisect 2.6.20-2.6.21?

I'd of course happily merge the fix which initializes the value properly 
into my tree, but I would be curious what broke it, to double check that 
we didn't break anything else along with it.

Thanks,

-- 
Jiri Kosina
