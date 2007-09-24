From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Problem with appletouch driver in Linux version 2.6.23-rc7
Date: Mon, 24 Sep 2007 13:49:31 +0100
Message-ID: <20070924124931.GA22649@srcf.ucam.org>
References: <46F54D92.7000300@tng.de> <d120d5000709240540ic91832em277a6bcbb399cd45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
In-Reply-To: <d120d5000709240540ic91832em277a6bcbb399cd45@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Rohwer <tr@tng.de>, linux-input@atrey.karlin.mff.cuni.cz, Soeren Sonnenburg <kernel@nn7.de>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 24, 2007 at 08:40:56AM -0400, Dmitry Torokhov wrote:
> On 9/22/07, Thomas Rohwer <tr@tng.de> wrote:
> > I tried Linux version 2.6.23-rc7 on my macbook pro using the appletouch input driver.
> > I noticed that often release events for the touchpad button are missing. This does not
> > occur with Linux version 2.6.22. I suppose this is related to the new reset logic in
> > the driver introduced in 2.6.23. If a reset occurs while the button is pressed the
> > release event seems to be not sent sometimes. The attached patch fixes the problem for me. It
> > changes the count towards idle so that the count is only incremented if the touchpad
> > button is not pressed. I also attached the output of lsusb.txt.

I'd spotted this, but hadn't got around to fixing it yet. Thanks for 
picking it up!

> I will fix these up myself, you don't need to resubmit the patch. I
> only need "Signed-off-by: ... " line from you. Thanks!

Acked-by: Matthew Garrett <mjg59@srcf.ucam.org>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
