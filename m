From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] input: pixcir_i2c: Remove text about writing to Free
 Software Foundation
Date: Fri, 19 Aug 2016 10:17:43 -0700
Message-ID: <20160819171743.GI20499@dtor-ws>
References: <1471440134-23896-1-git-send-email-clabbe.montjoie@gmail.com>
 <1471440134-23896-2-git-send-email-clabbe.montjoie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471440134-23896-2-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Aug 17, 2016 at 03:22:13PM +0200, LABBE Corentin wrote:
> Checkpatch complains about the text suggesting writing to
> Free Software Foundation for GPLv2 license copy.
> This patch remove that text.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/pixcir_i2c_ts.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
> index b0a2dc2..d8b8889 100644
> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
> @@ -11,10 +11,6 @@
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>   * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public
> - * License along with this library; if not, write to the Free Software
> - * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
>   */
>  
>  #include <linux/delay.h>
> -- 
> 2.7.3
> 

-- 
Dmitry
