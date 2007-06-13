From: Diogo Kastrup <dk@bighost.com.br>
Subject: Re: [patch] hid: fix autocentering of PID devices
Date: Wed, 13 Jun 2007 19:20:27 -0300
Message-ID: <1181773227.11608.8.camel@ip6-localhost>
References: <466FDC51.5030703@gmail.com>
	 <Pine.LNX.4.64.0706131746020.23280@twin.jikos.cz>
	 <46705CBD.5040302@gmail.com>
	 <Pine.LNX.4.64.0706132340560.23280@twin.jikos.cz>
	 <4670673A.3050702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <4670673A.3050702@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: Jiri Kosina <jikos@jikos.cz>, Dmitry Torokhov <dtor@insightbb.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Anssi Hannula wrote:
> Jiri Kosina wrote:
> > On Thu, 14 Jun 2007, Anssi Hannula wrote:
> > 
> >>> do you have any idea what caused this to happen in 2.6.21 and not in 
> >>> earlier versions?
> >> Nope. Do you think it would be useful for me to bisect 2.6.20-2.6.21?
> > 
> > I'd of course happily merge the fix which initializes the value properly 
> > into my tree, but I would be curious what broke it, to double check that 
> > we didn't break anything else along with it.
> 
> Okay, I'll get back to you in a few days :)

Hi,

Now that I was trying to remember the first time I saw this problem, I
think it was randomly showing up long time ago, then stopped. I thought
it was on the last kernel because recently I stepped on it again while
writing a program to calibrate and configure my joystick forces. But I
don't use my joystick on linux that much so I'm not sure, sorry.
-- 
Diogo Kastrup <dk@bighost.com.br>
