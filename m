From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [patch] hid: fix autocentering of PID devices
Date: Wed, 13 Jun 2007 17:48:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0706131746020.23280@twin.jikos.cz>
References: <466FDC51.5030703@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <466FDC51.5030703@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-input@atrey.karlin.mff.cuni.cz, Diogo Kastrup <dk@bighost.com.br>
List-Id: linux-input@vger.kernel.org

On Wed, 13 Jun 2007, Anssi Hannula wrote:

> When setting the autocentering of PID devices, PID_DIRECTION_ENABLE is 
> not being explicitely set to 1. This results in autocentering working 
> only on the vertical axis when this field is preset to 0. This seems to 
> happen since 2.6.21.

Hi Anssi,

do you have any idea what caused this to happen in 2.6.21 and not in 
earlier versions?

-- 
Jiri Kosina
