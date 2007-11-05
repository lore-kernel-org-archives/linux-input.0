From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Fix incorrect usage of strncpy and strncat in i8042_pnp_kbd_probe(); drivers/input/serio/i8042-x86ia64io.h
Date: Mon, 5 Nov 2007 16:08:18 -0500
Message-ID: <d120d5000711051308p62094becnce4fdb57cb30687a@mail.gmail.com>
References: <472F7C02.9040600@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <472F7C02.9040600@tiscali.nl>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Roel Kluin <12o3l@tiscali.nl>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Roel,

On Nov 5, 2007 3:24 PM, Roel Kluin <12o3l@tiscali.nl> wrote:
> See http://www.gratisoft.us/todd/papers/strlcpy.html
> --
> Fix incorrect length argument for  strncpy and strncat by replacing them with

What is incorrect about the argument?

> respectively strlcpy and strlcat

I will gladly take a patch replacing strncat with strlcat but don't
error out if the buffer is too small - it is oK if PNP name is printed
truncated, it does not affect KBC operations.

Thanks.

-- 
Dmitry
