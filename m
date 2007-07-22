From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: Re: [HP Jornada 6XX] - Onboard Keyboard support
Date: Sun, 22 Jul 2007 08:59:30 -0700
Message-ID: <20070722085930.640ab152.Kristoffer.Ericson@Gmail.com>
References: <20070721181549.9d118414.Kristoffer.Ericson@Gmail.com>
	<200707220145.10563.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200707220145.10563.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Ah, I'll look into that then. Thx

On Sun, 22 Jul 2007 01:45:10 -0400
Dmitry Torokhov <dtor@insightbb.com> wrote:

> On Saturday 21 July 2007 21:15, Kristoffer Ericson wrote:
> > Greetings,
> > 
> > Here we go again with another keyboard patch (this time for hp6xx).
> > It consists of three files, where one contains the generic scan_keyb
> > routines with needed header and the third is the specific hp6xx driver.
> 
> Please do not use scan_keyb. It goes around input core and directly into
> legacy keyboard driver. For drivers that periodically poll/scan their
> device input_polldev might be of interest.
> 
> -- 
> Dmitry


-- 
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
