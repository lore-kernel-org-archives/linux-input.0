From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: Ever-increasing serio device number
Date: Fri, 22 Jun 2007 15:30:50 -0400
Message-ID: <d120d5000706221230s33378c69m2b1f0a9320727b7a@mail.gmail.com>
References: <20070621230040.79fe959d@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070621230040.79fe959d@hyperion.delvare>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Ejan,

On 6/21/07, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Dmitry, hi all,
>
> While developing my i2c-taos-evm driver [1], I noticed that my device
> was getting a new serio device number each time I cycled my driver. It
> started as serio2, and after an afternoon of testing, it was serio19.
> I'm curious, is this intended? I expected freed numbers to be reused,
> as i2c does.
>
> If this isn't supposed to happen, would this be a bug in the serio
> driver, or in my driver (maybe not releasing some resource properly)?
>

Serio system (as well as gameport and input core) simply assign next
number for each newly registered serio device, it does not try to
reuse old ids. If you want to identify a specific device you need to
rely on phys and id/* attributes (when available).

-- 
Dmitry
