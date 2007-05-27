From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] ACPI: thinkpad-acpi: add thinkpad keys to input.h
Date: Sat, 26 May 2007 23:40:27 -0400
Message-ID: <200705262340.28219.dtor@insightbb.com>
References: <11802004861625-git-send-email-hmh@hmh.eng.br> <11802006652058-git-send-email-hmh@hmh.eng.br> <1180200665989-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1180200665989-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Saturday 26 May 2007 13:31, Henrique de Moraes Holschuh wrote:
> Add hotkeys available in almost all ThinkPads manufactured in the last five
> years (more than one million machines given the ammount of batteries
> recalled) to input.h, and make thinkpad-acpi use those instead of issuing
> KEY_UNKNOWN.
> 
> KEY_FN_PAGEDOWN is not ever reported by the ThinkPad firmware due to random
> bogon-induced stupidity at IBM some years ago, but it is provided because
> it doesn't make sense to define KEY_FN_PAGEUP and not define
> KEY_FN_PAGEDOWN at the same time.
> 

I am unconvinced that we need new keycodes. Isn't there a better default
keycodes for these keys? You mentioned that fn+f5 controls radio on many
thinkpads, why don't you use KEY_WLAN in your keymap?
 
-- 
Dmitry
