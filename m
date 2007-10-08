From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: GeneralTouch USB Touchscreen Support
Date: Mon, 8 Oct 2007 16:36:11 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0710081633330.25413@twin.jikos.cz>
References: <f37dba8b0710080305t37b57e3dpe2fd7be231893ba5@mail.gmail.com>
 <d120d5000710080623o4a0be879w45d59be6ee025d40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000710080623o4a0be879w45d59be6ee025d40@mail.gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: zeylienospam@gmail.com, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Mon, 8 Oct 2007, Dmitry Torokhov wrote:

> The patch looks good, thanks a lot. Can I please have your 
> "Signed-off-by:" so I can apply it?  Thanks!

Hi,

my only concern with this patch is -- could we please keep the entries in 
hid_blacklist[] properly sorted? (i.e. first by quirk type, then by vendor 
name).

Also, patch to hid-quirks seem to contain some whitespace changes, I'd 
like to do this separately if possible.

Besides that, I am fine with that and you can add

	Signed-off-by: Jiri Koisna <jkosina@suse.cz>

for the HID part of the patch if you want to.

Thanks,

-- 
Jiri Kosina
