From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Problem with appletouch driver in Linux version 2.6.23-rc7
Date: Mon, 24 Sep 2007 08:40:56 -0400
Message-ID: <d120d5000709240540ic91832em277a6bcbb399cd45@mail.gmail.com>
References: <46F54D92.7000300@tng.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <46F54D92.7000300@tng.de>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Thomas Rohwer <tr@tng.de>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Soeren Sonnenburg <kernel@nn7.de>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-input@vger.kernel.org

Hi Thomas,

On 9/22/07, Thomas Rohwer <tr@tng.de> wrote:
> Hello,
>
> I tried Linux version 2.6.23-rc7 on my macbook pro using the appletouch input driver.
> I noticed that often release events for the touchpad button are missing. This does not
> occur with Linux version 2.6.22. I suppose this is related to the new reset logic in
> the driver introduced in 2.6.23. If a reset occurs while the button is pressed the
> release event seems to be not sent sometimes. The attached patch fixes the problem for me. It
> changes the count towards idle so that the count is only incremented if the touchpad
> button is not pressed. I also attached the output of lsusb.txt.
>
> As I am not subscribed to the list, please cc me in replies.
>

Yep, this makes sense, thank you for the patch. Couple of comments:

>        y = atp_calculate_abs(dev->xy_acc + ATP_XSENSORS, ATP_YSENSORS,
>                              ATP_YFACT, &y_z, &y_f);
>
> +       int key= dev->data[dev->datalen - 1] & 1;

We do not normally put variable definitions in the middle of the code
but at the beginning of the block.

>                   the first touch unless reinitialised. Do so if it's been
>                   idle for a while in order to avoid waking the kernel up
>                   several hundred times a second */
> !               if (atp_is_geyser_3(dev)) {

Unified diffs please.

I will fix these up myself, you don't need to resubmit the patch. I
only need "Signed-off-by: ... " line from you. Thanks!

-- 
Dmitry
