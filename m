From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH] INPUT: fix hidinput_connect ignoring retval from
 input_register_device
Date: Mon, 29 Oct 2007 18:28:36 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0710291827140.18815@twin.jikos.cz>
References: <20071029152050.GA23411@bigserver.hohndel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20071029152050.GA23411@bigserver.hohndel.org>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dirk Hohndel <hohndel@linux.intel.com>
Cc: Jeff Garzik <jeff@garzik.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 29 Oct 2007, Dirk Hohndel wrote:

> 	hidinput = kzalloc(sizeof(*hidinput), GFP_KERNEL);
> 	input_dev = input_allocate_device();
> 	if (!hidinput || !input_dev) {
> 		kfree(hidinput);
> 		input_free_device(input_dev);
> This either passes a NULL pointer to kfree or to input_free_device. That's
> not nice.

Actually both of the cases are fine -- it is valid to pass NULL pointer to 
kfree() and to input_free_device() too.

> Would something like this work?

Yes, I think that this patch is in principle fine, modulo the redundant 
NULL-ptr checks.

Thanks,

-- 
Jiri Kosina
