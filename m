From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] psmouse: add support for 4th button using the 4th bit
Date: Wed, 9 May 2007 11:39:04 -0400
Message-ID: <d120d5000705090839k2b7e3915j3c66173b7b8af1a6@mail.gmail.com>
References: <20070402204810.GC14838@redhat.com>
	 <d120d5000704030739v5528fb2cq6f9aed387ade03b8@mail.gmail.com>
	 <20070403144243.GE14838@redhat.com>
	 <d120d5000704030805l397a61d5x99b8fdb138b6881d@mail.gmail.com>
	 <20070508185327.GB4215@redhat.com>
	 <d120d5000705090736p145b6a7cn8645eccdb5c35ca3@mail.gmail.com>
	 <20070509145337.GD4215@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070509145337.GD4215@redhat.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Aristeu Rozanski <arozansk@redhat.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Chris Williams <cww@redhat.com>
List-Id: linux-input@vger.kernel.org

On 5/9/07, Aristeu Rozanski <arozansk@redhat.com> wrote:
> --- linus-2.6.orig/drivers/input/mouse/psmouse.h
> +++ linus-2.6/drivers/input/mouse/psmouse.h
> @@ -78,6 +78,7 @@ struct psmouse {
>  enum psmouse_type {
>        PSMOUSE_NONE,
>        PSMOUSE_PS2,
> +       PSMOUSE_CORTRON,
>        PSMOUSE_PS2PP,
>        PSMOUSE_THINKPS,
>        PSMOUSE_GENPS,
>

I moved PSMOUSE_CORTRON to the end of the list - psmouse type is
exported to userspace as input_dev.id.product and so we should not
change existing types.

-- 
Dmitry
