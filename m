From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Problem with appletouch driver in Linux version 2.6.23-rc7
Date: Sat, 13 Oct 2007 22:44:04 +0100
Message-ID: <20071013214404.GA14626@srcf.ucam.org>
References: <46F54D92.7000300@tng.de> <d120d5000709240540ic91832em277a6bcbb399cd45@mail.gmail.com> <1190638998.12782.0.camel@localhost> <46F7BA08.6000201@tng.de> <1190836596.1359.33.camel@localhost> <d120d5000709261313j16f9612fx7d445b707df7784b@mail.gmail.com> <1190915501.7636.4.camel@localhost> <46FC1BC4.5050405@tng.de> <1192311190.4828.97.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <1192311190.4828.97.camel@localhost>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Thomas Rohwer <tr@tng.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Sat, Oct 13, 2007 at 11:33:10PM +0200, Soeren Sonnenburg wrote:
> On Thu, 2007-09-27 at 23:08 +0200, Thomas Rohwer wrote:
> > I was also wondering when the procedure atp_reinit is executed after using schedule_work.
> > Can it happen that atp_complete is called (even multiple times) before atp_reinit is executed?
> 
> I have no idea, Matthew?

My recollection is that atp_complete is called in a context that doesn't 
permit sending new urbs.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
