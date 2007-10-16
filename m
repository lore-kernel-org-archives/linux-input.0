From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Map MS Presenter 8000 bottom-side buttons
Date: Tue, 16 Oct 2007 12:16:12 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0710161214440.12935@jikos.suse.cz>
References: <4713A4D9.4060909@siemens.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <4713A4D9.4060909@siemens.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Mon, 15 Oct 2007, Jan Kiszka wrote:

> +			} else if (device->vendor == 0x045e && device->product == 0x0713) {
> +				set_bit(EV_REP, input->evbit);
> +				switch(usage->hid & HID_USAGE) {
> +					/* Make MS Presenter 8000 bottom-side keys useful,
> +					 * e.g. under OOffice */
> +					case 0xfd08: map_key_clear(KEY_RIGHT);		break;
> +					case 0xfd09: map_key_clear(KEY_LEFT);		break;
> +					case 0xfd0b: map_key_clear(KEY_PAUSE);		break;
> +					case 0xfd0f: map_key_clear(KEY_F5);		break;
> +					default:    goto ignore;
> +				}
> +			} else

Hi Jan,

could you please take a short look at current Linus' git tree - there are 
some more devices using MSVENDOR page, and we have introduced macros to 
match them. It would be great if you could redo the patch to fit into this 
picture and send it to me again.

Thanks,

-- 
Jiri Kosina
SUSE Labs
