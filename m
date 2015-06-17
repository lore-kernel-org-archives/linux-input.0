From: Jeremiah Mahler <jmmahler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 0/7] instruction of cyapa gen6 and proximity patches
Date: Wed, 17 Jun 2015 15:09:24 -0700
Message-ID: <20150617220924.GA6903@hudson.localdomain>
References: <1434358897-24668-1-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434358897-24668-1-git-send-email-dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dudley Du <dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org, bleung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Dudley,

On Mon, Jun 15, 2015 at 05:01:30PM +0800, Dudley Du wrote:
> V1 patches mainly have following updates compared with V0 patches:
> 1) This patch series is generated base on code base linux-next 20150612,
>    so fix the patch v0 6/7 failed to apply on linux-next 20150611 issue.
> 1) Fix spelling errors, space and black line format errors in patch v1 1/7.
> 2) Add detail description of the new interrupt and proximity interfaces in
>    patch v1 5/7.
> 
> 
> This patch series is mainly aimed to add new gen6 trackpad devices support,
> and also new function to report proximity data/vent for Gen5 and Gen6 trackpad
> devices.
> 
> 
> Dudley Du (7):
>   input: cyapa: change strings of gen5 to pip in the name when they are
>     shared
>   input: cyapa: add gen6 device module support in driver
>   input: cyapa: add proximity function support for gen5 and gen6 modules
>   input: cyapa: fully support runtime suspend power management
>   input: cyapa: add proximity and interrupt sysfs interfaces support
>   input: cyapa: add of match device support and description document
>   input: cyapa: add CYAP0002 Gen6 device for ACPI configuration
> 
>  .../devicetree/bindings/input/cypress,cyapa.txt    |   44 +
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  drivers/input/mouse/Makefile                       |    2 +-
>  drivers/input/mouse/cyapa.c                        |  266 ++++-
>  drivers/input/mouse/cyapa.h                        |  161 ++-
>  drivers/input/mouse/cyapa_gen3.c                   |   11 +-
>  drivers/input/mouse/cyapa_gen5.c                   | 1254 +++++++++++---------
>  drivers/input/mouse/cyapa_gen6.c                   |  760 ++++++++++++
>  8 files changed, 1854 insertions(+), 645 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/cypress,cyapa.txt
>  create mode 100644 drivers/input/mouse/cyapa_gen6.c
> 
> 
> History patch series modifications list:
> V0 patches mainly have following updates:
> 1) Add Gen6 trackpad device support;
> 2) Add report proximity data function support for Gen5 and Gen6 devices;
> 3) Fully support runtime suspend/resume power management;
> 4) Add of_match_table mechanism support.
> 
> -- 
> 1.9.1
> 

This patch series works good on my Acer C720 Chromebook running
linux-next 20150615.

Tested-by: Jeremiah Mahler <jmmahler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

-- 
- Jeremiah Mahler
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
