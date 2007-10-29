From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] INPUT: fix hidinput_connect ignoring retval from input_register_device
Date: Mon, 29 Oct 2007 08:54:59 -0400
Message-ID: <d120d5000710290554x618eca05tbf864a0f7f9b77a5@mail.gmail.com>
References: <20071029084917.GA12968@bigserver.hohndel.org>
	 <Pine.LNX.4.64.0710291113450.18815@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0710291113450.18815@twin.jikos.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Dirk Hohndel <hohndel@linux.intel.com>, Jeff Garzik <jeff@garzik.org>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 10/29/07, Jiri Kosina <jikos@jikos.cz> wrote:
> On Mon, 29 Oct 2007, Dirk Hohndel wrote:
>
> > [INPUT] hidinput_connect incorrectly ignored return value from
> > input_register_device
> > Signed-off-by: Dirk Hohndel <hohndel@linux.intel.com>
>
> Will apply

Please don't - the fix is completely broken for multi-input devices -
if 2nd device fails to register we bail out of hidinput_connect and
thus never set HID_CLAIMED_INPUT bit. So when we disconnect device we
never call hidinput_disconnect and who knows what will happen after
that.

hidinput_connect() should properly unwind already registered devices
after failure.

-- 
Dmitry
