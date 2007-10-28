From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [2.6 patch] input/serio/hp_sdc.c section fix
Date: Sun, 28 Oct 2007 01:03:20 -0400
Message-ID: <200710280103.21192.dtor@insightbb.com>
References: <20071024162640.GO30533@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20071024162640.GO30533@stusta.de>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wednesday 24 October 2007 12:26, Adrian Bunk wrote:
> hp_sdc_exit() mustn't be __exit since it's called from the
> __init hp_sdc_register().
> 

Applied, thank you Adrian.

-- 
Dmitry
