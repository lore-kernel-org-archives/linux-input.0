From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Enabling "extra" scancodes on some Acer laptops
Date: Tue, 16 Oct 2007 10:37:37 -0400
Message-ID: <d120d5000710160737p188215fei5c4c56ef5734ae2d@mail.gmail.com>
References: <200710141803.09039.cathectic@slackadelic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200710141803.09039.cathectic@slackadelic.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Carlos Corbacho <cathectic@slackadelic.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Carlos,

On 10/14/07, Carlos Corbacho <cathectic@slackadelic.com> wrote:
>
> After calling set_keyboard_quirk(), the extra keys start generating proper
> scancodes, and can be mapped as normal via setkeycodes.
>
> At the moment, I've added this quirk to acer_acpi (it's currently only applied
> on the few systems we know that need it via DMI matching), but I'm not really
> sure if this is the right place for it as:
>
> 1) acer_acpi is still out of tree
>
> 2) Does this really belong in acer_acpi (I'm not really sure if it falls under
> what I'm doing - this seems to border a bit too much on the input tree side),
> or somewhere further up the input tree (wistron-btns isn't much use here, as
> the quirk would then be limited to 32 bit only, whereas some of the machines
> that need this quirk can run a 64 bit kernel)?
>

I think it could be added to i8042 driver to enable it. How messy is detection?

I am also going to apply the patch that exports i8042_command() so it
can be used by other modules (Clevo LED driver needs it).

-- 
Dmitry
