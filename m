From: Rodolfo Giometti <giometti@enneenne.com>
Subject: Re: [PATCH] PXA27x keyboard support
Date: Wed, 21 Feb 2007 15:07:11 +0100
Message-ID: <20070221140710.GA13951@enneenne.com>
References: <20061120155518.GA6910@enneenne.com> <20061120160516.GC6910@enneenne.com> <200611240109.22900.dtor@insightbb.com> <20061124143534.GI11606@enneenne.com> <Pine.LNX.4.64.0611241030440.9647@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611241030440.9647@xanadu.home>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Nicolas Pitre <nico@cam.org>, Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-input@vger.kernel.org

Hello,

I'm working again on PXA27x keyboard support since I'd like to add
backlight support.

Since my hardware doesn't support "direct interface" but only "matrix
scan" what I can do is to integrate as much possible of the code of
your patch into the new driver so if someone has a mainstone can do an
easy port.

It could be acceptable?

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127
