From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 1/2] Add acer wmi hotkey events support
Date: Fri, 1 Oct 2010 16:03:42 +0200
Message-ID: <AANLkTimnRzpVDCt96ZjNduw5zMtDfGX+5FhCQb58bXpA@mail.gmail.com>
References: <1285941088-31196-1-git-send-email-jlee@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1285941088-31196-1-git-send-email-jlee@novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, tiwai@novell.com, trenn@novell.com, jbenc@suse.cz, "Lee, Chun-Yi" <jlee@novell.com>
List-Id: linux-input@vger.kernel.org

On Fri, Oct 1, 2010 at 3:51 PM, Lee, Chun-Yi <joeyli.kernel@gmail.com> wrote:
> Add acer wmi hotkey event support. Install a wmi notify handler to
> transfer wmi event key to key code, then send out keycode through acer
> wmi input device to userland.
>
> Signed-off-by: Lee, Chun-Yi <jlee@novell.com>

Hi Lee,
You'll probably want to take a look at the sparse keymap library. Using
it would remove a lot of code from this patch.
Thanks

-- 
Corentin Chary
http://xf.iksaif.net
