From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH] INPUT: fix hidinput_connect ignoring retval from
 input_register_device
Date: Mon, 29 Oct 2007 13:57:25 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0710291355540.18815@twin.jikos.cz>
References: <20071029084917.GA12968@bigserver.hohndel.org>
 <Pine.LNX.4.64.0710291113450.18815@twin.jikos.cz>
 <d120d5000710290554x618eca05tbf864a0f7f9b77a5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000710290554x618eca05tbf864a0f7f9b77a5@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dirk Hohndel <hohndel@linux.intel.com>, Jeff Garzik <jeff@garzik.org>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 29 Oct 2007, Dmitry Torokhov wrote:

> Please don't - the fix is completely broken for multi-input devices -
> if 2nd device fails to register we bail out of hidinput_connect and
> thus never set HID_CLAIMED_INPUT bit. So when we disconnect device we
> never call hidinput_disconnect and who knows what will happen after
> that.

You are of course right, stupid me. I won't commit anything before first 
morning coffee any more.

Thanks a lot.

-- 
Jiri Kosina
